using Oceananigans

# Coriolis frequency
f = 1e-4
# Shear
S = f
# Richardson number
Ri = 0.3
# Stratification
N² = Ri * S^2

# Dimensions
L = 100
N = 512

# Initial time step and total runtime
Δt = 1e-2 / f
T = 50 / f

# Create a grid
grid = RectilinearGrid(; size=(N, N), extent=(L, L), topology=(Periodic, Flat, Bounded))

# Define continuous forcing functions
@inline v_forcing_func(x, z, t, u, w) = -(S * w)
@inline b_forcing_func(x, z, t, u, w) = -(f * S * u + N² * w)

forcing = (;
    v = Forcing(v_forcing_func; field_dependencies=(:u, :w)),
    b = Forcing(b_forcing_func; field_dependencies=(:u, :w))
)

# Create a model
model = NonhydrostaticModel(; 
    grid,
    advection = WENO(; order=5),
    forcing,
    coriolis=FPlane(; f),
    tracers = (:b, :c),
    buoyancy=BuoyancyTracer()
)

# Set initial conditions (some noise and a linear tracer profile)
@inline u₀(x, z) = 1e-8 * randn()
@inline c₀(x, z) = -z
set!(model; c=c₀, u=u₀)

# Create simulation
simulation = Simulation(model; Δt, stop_time=T)

# Output some progress info
function progress(simulation)
    i = iteration(simulation)
    t = prettytime(time(simulation))
    
    print("$i, t=$t\r")
end
simulation.callbacks[:progress] = Callback(progress, TimeInterval(10Δt))

# Configure a variable time step
wizard = TimeStepWizard(; cfl=0.5)
simulation.callbacks[:wizard] = Callback(wizard, IterationInterval(10))

# Model fields
u, v, w = model.velocities
b, c = model.tracers

# Output metadata
function init_jld2!(file, model)
    file["metadata/parameters"] = (; Ri, S, N², f)
    file["metadata/description"] = "Symmetric instability in a finite front"
    return nothing
end

# Configure output writer
simulation.output_writers[:raw] = JLD2Writer(model, (; u, v, w, b, c);
    filename = "raw-512.jld2",
    overwrite_existing = true,
    init=init_jld2!,
    schedule = TimeInterval(10Δt)
)

# Run simulation
run!(simulation)