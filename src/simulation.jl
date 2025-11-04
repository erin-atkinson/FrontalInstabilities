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

# Dimensions typical of submesoscale, but keep aspect ratio low for WENO
L = 1_000
H = 100
Nx = 512
Nz = 64

# Initial time step and total runtime
Δt = 1e-2 / f
T = 120 / f

# Exercise 1: Create a grid
#
#
#

# Exercise 2: Define continuous forcing functions
#
#
#

forcing = (;
    v = Forcing(v_forcing_func; field_dependencies=(:u, )),
    b = Forcing(b_forcing_func; field_dependencies=(:u, :w))
)

# Create a model
model = NonhydrostaticModel(; 
    grid,
    advection = WENO(; order=5),
    forcing,
    coriolis = FPlane(; f),
    tracers = (:b, :c),
    buoyancy = BuoyancyTracer()
)

# Initial conditions
# Random noise in u
@inline u₀(x, z) = 1e-8 * randn()

# Exercise 3: Initial tracer profile
#
#
#

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
simulation.callbacks[:progress] = Callback(progress, TimeInterval(20Δt))

# Configure a variable time step
wizard = TimeStepWizard(; cfl=0.5)
simulation.callbacks[:wizard] = Callback(wizard, IterationInterval(10))

# Model fields
u, v, w = model.velocities
b, c = model.tracers

# Exercise 4: Derived fields
# Total buoyancy gradient
#
#
#

# Output metadata
function init_jld2!(file, model)
    file["metadata/parameters"] = (; Ri, S, N², f, L, H, Nx, Nz, Δt, T)
    file["metadata/description"] = "Symmetric instability in a frontal zone"
    return nothing
end

# Configure output writer
simulation.output_writers[:output] = JLD2Writer(model, (; u, v, w, b, c, N²_tot);
    filename = "output.jld2",
    overwrite_existing = true,
    init=init_jld2!,
    schedule = TimeInterval(20Δt)
)

# Run simulation
run!(simulation)
