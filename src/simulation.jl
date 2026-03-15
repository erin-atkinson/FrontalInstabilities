#=
simulation.jl
    Create a simulation of symmetric instability in a frontal zone
=#
using Oceananigans

# Coriolis frequency
f = 1e-4
# Shear
S = f
# Richardson number
Ri = 0.5
# Stratification
N² = Ri * S^2

# Dimensions typical of submesoscale, but keep aspect ratio close to unity
L = 1_000
H = 100
Nx = 512
Nz = 64

# Initial time step and total runtime
Δt = 1e-2 / f
T = 120 / f

# Exercise 1: create a grid
grid = 

# Exercise 2: define continuous forcing functions
@inline v_forcing_func(...) = 
@inline b_forcing_func(...) = 

forcing = 

# Other model arguments
advection = WENO(; order=5)
coriolis = FPlane(; f)
buoyancy = BuoyancyTracer()
tracers = (:b, :c)

# Create a model
model = NonhydrostaticModel(; 
    grid,
    advection,
    forcing,
    coriolis,
    tracers,
    buoyancy,
)

# Initial conditions
# Random noise in u
@inline u₀(x, z) = 1e-8 * randn()

# Exercise 3: initial tracer profile
@inline c₀(x, z) = 

set!(model; c=c₀, u=u₀)

# Create simulation
simulation = Simulation(model; Δt, stop_time=T)

# Output some progress info
function progress(simulation)
    i = iteration(simulation)
    t = prettytime(time(simulation))
    T = prettytime(simulation.stop_time)

    print(rpad("$i, t=$t / $T", 60, ' ') * "\r")
end
simulation.callbacks[:progress] = Callback(progress, TimeInterval(100Δt))

# Configure a variable time step
wizard = TimeStepWizard(; cfl=0.5)
simulation.callbacks[:wizard] = Callback(wizard, IterationInterval(10))

# Model fields
u, v, w = model.velocities
b, c = model.tracers

# Derived fields
# Total buoyancy gradient
N²_tot = Field(∂z(b) + N²)

# Output metadata
function init_jld2!(file, model)
    file["metadata/parameters"] = (; Ri, S, N², f, L, H, Nx, Nz, Δt, T)
    file["metadata/description"] = "Symmetric instability in a frontal zone"
    return nothing
end

# Configure output writer
simulation.output_writers[:output] = JLD2Writer(model, (; u, v, w, b, c, N²_tot);
    filename = "Ri05.jld2",
    overwrite_existing = true,
    init=init_jld2!,
    schedule = TimeInterval(20Δt)
)

# Run simulation
run!(simulation)
