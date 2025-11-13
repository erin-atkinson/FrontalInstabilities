using Oceananigans
using Oceananigans.Fields: instantiated_location

input = ARGS[1]
output = replace(ARGS[1], ".jld2" => "-pp.jld2")

# Read in the raw output
fds = FieldDataset(input; backend=OnDisk())
N²_tot_fts = fds.N²_tot
w_fts = fds.w
c_fts = fds.c
p = fds.metadata["parameters"]
times = c_fts.times

# Initialize input fields
N²_tot = N²_tot_fts[1]
w = w_fts[1]
c = c_fts[1]

# Balanced Ri
Ri_b = Field(Average(N²_tot / p.S^2))

c_avg = Field(Average(c))
w_avg = Field(Average(w))

c′ = c - c_avg
w′ = w - w_avg

w′c′_avg = Field(Average(w′ * c′))

outputs = (; Ri_b, w′c′_avg)

output_fds = FieldDataset(times, outputs; 
    backend = OnDisk(), 
    path = output,
    metadata = fds.metadata
)

# Iterate over times
N = length(c_fts)
for n in 1:N
    # Set input
    set!(N²_tot, N²_tot_fts[n])
    set!(w, w_fts[n])
    set!(c, c_fts[n])

    # Perform operation
    # NB: compute! will by default call compute! on all dependencies
    # see Oceananigans.Fields.compute_at!
    compute!(outputs)

    # Save the result
    set!(output_fds, n; outputs...)

    print("$n / $N\r")
end
