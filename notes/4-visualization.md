# Making a video of the simulation
Simulation output data can be read into memory using `FieldTimeseries`
```
u_timeseries = FieldTimeSeries(filename, "u")
```
These can then be plotted with `GLMakie`. A simple plot of the final state of u can be made with `heatmap`.
```julia
u_timeseries = FieldTimeSeries(filename, "u")
n = length(u_timeseries)
u = interior(u_timeseries, :, 1, :, n)
heatmap(x, z, u)
```

We can construct more complicated plots by first defining a figure object, such as this plot combining a heatmap for $v$ and a set of contours (isopycnals) for $b$. For consistency, I find the color range and contour levels before plotting.

The [cmocean](https://docs.makie.org/stable/explanations/colors#cmocean) colormaps are common in climate science. Pick one you think is appropriate/looks nice :).

> ### Exercise 1
>
> Add a heatmap of the passive tracer $c$ to `visualization.jl`

Animations of existing plots is easy to implement using `Makie`'s `Observable` system.

> ### Exercise 2
>
> Modify the `visualization.jl` to make an animation.
