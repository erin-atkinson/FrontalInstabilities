using Oceananigans
using Oceananigans.Operators

input = ARGS[1]
output = replace(ARGS[1], ".jld2" => "-pp.jld2")

# Read in the raw output
fds = FieldDataset(input; backend=OnDisk())
b_fts = fds.b
p = fds.metadata["parameters"]
b = b_fts[1]
grid = b.grid

# Create our new field
function Ri_func(i, j, k, grid, b, S, N²)
    tot = 0
    for _i in 1:grid.Nx, _k in 1:grid.Nz
        tot += ∂zᶜᶜᶠ(_i, j, _k, grid, b)
    end
    return (N² + tot) / (S^2 * grid.Nx * grid.Nz)
end

Ri = Field(KernelFunctionOperation{Nothing, Center, Nothing}(Ri_func, grid, b, p.S, p.N²))

# Create a timeseries to save our results
Ri_series = FieldTimeSeries{Nothing, Center, Nothing}(grid, b_fts.times; 
                                                     name = "Ri", 
                                                     backend = OnDisk(), 
                                                     path = output
                                                    )

# Iterate over times
N = length(b_fts)
@time for n in 1:N
    # Set input
    set!(b, b_fts[n])

    # Perform operation
    compute!(Ri)

    # Save the result
    set!(Ri_series, Ri, n)

    print("$n / $N\r")
end
