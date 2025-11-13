#=
transport.jl
    Transport of passive tracer for varying values of Ri
=#
using Oceananigans, GLMakie

filenames = [
    "Ri03-pp.jld2",
    "Ri05-pp.jld2",
    "Ri07-pp.jld2",
    "Ri09-pp.jld2",
]

datasets = [FieldDataset(filename; backend=OnDisk()) for filename in filenames]
#parameters = [dataset.metadata["parameters"] for dataset in datasets]

# Data to plot
fig = Figure(;
    size = (1200, 300),
    fontsize = 16
)

# Plot of the Richardson number
ax_Ri = Axis(fig[1, 1]; 
    ylabel = L"\text{Ri}_b",
    xlabel = L"t / \text{hr}",
    limits = (nothing, nothing, nothing, nothing)
)

ax_w′c′ = Axis(fig[1, 2]; 
    ylabel = L"\int_0^t \langle w'c' \rangle \text{d}t / \text{m}",
    xlabel = L"t / \text{hr}",
    limits = (nothing, nothing, nothing, nothing)
)

ax_w′c′_Ri = Axis(fig[1, 3]; 
    ylabel = L"\int_0^t \langle w'c' \rangle \text{d}t/ \text{m}",
    xlabel = L"\text{Ri}_b",
    limits = (nothing, nothing, nothing, nothing)
)

lns = map(datasets) do dataset
    t = dataset.Ri_b.times / 3600
    Ri_b = [dataset.Ri_b[n][1] for n in 1:length(t)]
    w′c′ = [dataset.w′c′_avg[n][1] for n in 1:length(t)] * 3600
    w′c′ = cumsum(w′c′) * (t[2] - t[1])
    lines!(ax_Ri, t, Ri_b)
    lines!(ax_w′c′, t, w′c′)
    lines!(ax_w′c′_Ri, Ri_b, w′c′)
end

#labels = ["$(round(p.Ri; digits=1))" for p in parameters]
labels = ["$(round(Ri; digits=1))" for Ri in [0.3, 0.5, 0.7, 0.9]]
Legend(fig[1, 4], lns, labels, L"\text{Ri}")

save("images/transport.png", fig; px_per_unit=2)
fig