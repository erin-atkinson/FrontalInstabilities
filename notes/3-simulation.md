# Basic Oceananigans setup
## Grid
> ### Exercise 1
> Add a basic definition of a grid to `simulation.jl`

## Fields
### Abstract operations

## Components of a model
### Forcing
> ### Exercise 2
> Define the continuous forcing functions `v_forcing_func(x, z, t)` and `b_forcing_func(x, z, t)`

### Boundary conditions

### Tracers

### Advection

### Closure

### Initial conditions
> ### Exercise 3
> Create a function `c₀(x, z)` with your desired initial conditions of the tracer $c$

## Simulation
### Creation
### Variable time steps
### Progress info

### Output
> ### Exercise 4
> Add an abstract operation to the output that computes the total buoyancy gradient $N^2 + \frac{\partial b}{\partial z}$

### Running
Once configured, a simulation can be run with simply
```julia
run!(simulation)
```

> ### Exercise 5
> Run the simulation. At $512\times 64$ resolution, it took about 15 minutes on my laptop (Ryzen 5 7640U, 12 threads) and the output file was ~500 MB. You can reduce the resolution if it takes too long (keep the aspect ratio 16:1, 8:1 or 4:1), or save timesteps less often if space is an issue.

