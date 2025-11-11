using Oceananigans
using Oceananigans.Fields: instantiated_location

input = ARGS[1]
output = replace(ARGS[1], ".jld2" => "-pp.jld2")

# Read in the raw output
fds = FieldDataset(input; backend=OnDisk())
b_fts = fds.b
v_fts = fds.v
w_fts = fds.w
p = fds.metadata["parameters"]

b = b_fts[1]
v = v_fts[1]
w = w_fts[1]
grid = c.grid

# Averaged tracer
b_avg = Field(Average(b; dims=(1, 2)))

# Perturbation
b′ = Field(b - b_avg)

# Covariance
w′b′ = Field(w * b′)

# Terms in effective diffusivity definition
w′b′_avg = Field(Average(w′b′; dims=(1, 2)))
b_avg_z = Field(∂z(b_avg))

# Effective diffusivity
κ = Field(- c_avg_z * w′c′_avg / (c_avg_z^2 + 1e-5))

outputs = (; KE)

ftss = NamedTuple(
    k => FieldTimeSeries(
        instantiated_location(v), 
        grid, 
        c_fts.times; 
        name = string(k), 
        backend = OnDisk(), 
        path = output
    )
    for (k, v) in pairs(outputs)
)

# Iterate over times
N = length(c_fts)
@time for n in 1:N
    # Set input
    set!(u, u_fts[n])
    set!(v, v_fts[n])
    set!(w, w_fts[n])
    set!(c, c_fts[n])

    # Perform operation
    # NB: compute! will by default call compute on all dependencies
    # see Oceananigans.Fields.compute_at!
    compute!(KE)

    # Save the result
    map(outputs, ftss) do v, fts
        set!(fts, v, n)
    end

    print("$n / $N\r")
end
