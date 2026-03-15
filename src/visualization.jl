#=
visualization.jl
    Create a visualization of simulation output
=#
using Oceananigans, GLMakie, Printf

filename = "Ri09.jld2"

# Read simulation data
fds = FieldDataset(filename; backend=OnDisk())
u_fts = fds.u
b_fts = fds.b
c_fts = fds.c
p = fds.metadata["parameters"]

# Parameters
L = p.L
H = p.H
Nx = p.Nx
Nz = p.Nz

# Prepare coordinates
x_u = xnodes(u_fts)
z_u = znodes(u_fts)

times = u_fts.times
# Index to plot
n = length(times)

# Data to plot
b₀ = [p.N² * z + p.f * p.S * x for x in x_c, z in z_c]
u = interior(u_fts[n], :, 1, :)
b = interior(b_fts[n], :, 1, :) .+ b₀
c = interior(c_fts[n], :, 1, :)

# Time in hours
time_string = let 
    t = times[n] / 3600
    t_str = @sprintf "%.1f" t
    L"t = %$t_str \, \text{hr}"
end

fig = Figure(;
    size = (1200, 500),
    fontsize = 16
)

# Time label
Label(fig[1, 1:2], time_string)

# Plot of the across-front velocity
ax_u = Axis(fig[2, 1]; 
    title = L"u / \text{m}\,\text{s}^{-1}",
    xlabel = L"x / \text{m}",
    ylabel = L"z / \text{m}",
    limits = (0, L, -H, 0)
)

ht_u = heatmap!(ax_u, x_u, z_u, u;
    colormap = :balance,
    colorrange = (-5e-3, 5e-3)
)

Colorbar(fig[2, 2], ht_u)

# Exercise 1: plot of the passive tracer
ax_c = 

ht_c = 

Colorbar(fig[3, 2], ht_c)

# Add some black buoyancy contours to each
contour!(ax_u, x_c, z_c, b;
    color = :black,
    levels = range(-2e-5, 2e-5, 20)
)

contour!(ax_c, x_c, z_c, b;
    color = :black,
    levels = range(-2e-5, 2e-5, 20)
)

fig
