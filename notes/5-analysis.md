# Analysis
This section covers some motivation for modelling instabilities in the first place in the form of their effect on an averaged state, introduces use of `ARGS` to allow Julia scripts to access command-line arguments, and describes post-processing using Oceananigans.

## Turbulence and effective diffusion
Due to the boundary conditions, no amount of the passive tracer $c$ can enter or leave the domain, it is conserved. However, as discussed in section 3, a simulation is not a true representation of an inviscid fluid. Our simulation has much more horizontal resolution than a regional or global model, so a first step at average dynamics may be to look at the horizontally-averaged value of a tracer. It is also useful to define perturbations from this average

$$
\langle c \rangle = \frac{1}{L}\int c\;\text{d}x \quad \text{and}\quad c'=c - \langle c\rangle
$$

How does $\langle c \rangle$ evolve? Well, we can start by considering its Lagrangian derivative.

$$
\frac{\text {D}\langle c \rangle}{\text{D}t} = \frac{\partial \langle c\rangle}{\partial t} + \vec u \cdot \nabla \langle c \rangle
$$
Using $\langle c \rangle = c - c'$ and taking a horizontal average (noting that $\langle \langle a\rangle\rangle = \langle a\rangle$)
$$
\left \langle\frac{\text {D}\langle c \rangle}{\text{D}t}\right \rangle = \left \langle\frac{\partial c}{\partial t}\right \rangle + \langle\vec u \cdot \nabla c\rangle -  \langle\vec u \cdot \nabla c'\rangle = \left \langle\frac{\text {D} c }{\text{D}t}\right \rangle - \langle \vec u \cdot \nabla c'\rangle =  - \langle \vec u' \cdot \nabla c'\rangle = - \nabla \cdot \langle \vec u' c'\rangle 
$$
Where incompressibility is used for the final equality. We end up with a tracer equation for $\langle c \rangle$, but this averaged tracer is no longer materially conserved as it has a non-zero Lagrangian derivative
$$
\frac{\text {D}\langle c \rangle}{\text{D}t} =- \nabla \cdot \langle \vec u' c'\rangle 
$$
(note that there will also be a direct effect of the sub-grid diffusivity due to the advection scheme/closure as discussed previously, but we ignore it here). As simulations at this fine resolution are impractical for larger regions, realistic simulations require that we model the effects of small-scale turbulence by producing estimates of the turbulent flux terms $\langle \vec u' c'\rangle $ (this _closes_ the set of equations for the averaged fields, hence the term _closure_). This can be done completely analytically for only simple cases, another method is to perform multiple small-scale simulations for a range of large-scale conditions, usually represented by non-dimensional numbers, and fit a curve. Here, we will assume that we can represent the small-scale flux as an effective diffusivity of the averaged field, namely,
$$
\langle w'c' \rangle \sim -\kappa_\text{eff} \frac{\partial \langle c \rangle}{\partial z} \implies \frac{\text {D}\langle c \rangle}{\text{D}t} = \frac{\partial}{\partial z}\left (\kappa_\text{eff}\frac{\partial \langle c \rangle}{\partial z}\right )
$$
> ### Exercise 1
> Show that, if $\kappa_\text{eff}(t)$ only,
> $$ \frac{\text{d} }{\text{d} t}\int\frac{1}{2}\langle c \rangle^2\text{d}z = -\kappa_\text{eff}\int\left (\frac{\partial \langle c \rangle}{\partial z}\right )^2 \text{d}z$$
> We can use this relationship to find an estimate for the diffusivity $\kappa_\text{eff}$, as we will do in the following section for different values of $\text{Ri}$.

## Parameter sweep

It would be impractical to edit `simulation.jl` each time we want to change some parameters. We can make use of the `ARGS` variable to run multiple versions of the same simulation. `ARGS` is a Julia environment variable that contains a vector of the command-line arguments the script was run with (not the arguments for `julia` itself). For instance, the simple program

```julia
# args-example.jl
for arg in ARGS
    println(arg)
end
```

when run with `julia args-example.jl one two three` will print
```

```
Note that all the entries are strings, so if we need a variable we must use `parse`:
```julia
# args-arithmetic.jl
a = parse(Float64, ARGS[1])
B = parse(Float64, ARGS[2])
println(a + b)
```
Now `julia args-arithmetic.jl 1e3 12.76` will produce

We can clearly separate arguments for `julia` from arguments for the script using a double-dash `--`:
```bash
julia -t 12 --project="env" -- args-arithmetic.jl 0.5 8e-2
```

> ### Exercise 2
>
> Modify the simulation code to instead read an initial $\text{Ri}$ value and output filename from the command-line arguments using `ARGS`, then run simulations for $\text{Ri} = \{0.3, 0.7, 0.9\}$ in addition to the existing $\text{Ri}=0.5$ output (which you may want to rename appropriately).
> Smaller $\text{Ri}$ will take longer (why?). Using the same resolution, the $\text{Ri} = 0.3$ simulation took 22 minutes.

# Post-processing
Once we have simulations for varying $\text{Ri}$, we can compare our results, however, first we will want to do some post-processing using Oceananigans. As well as simulations, Oceananigans provides powerful post-processing capabilities using `Field`s paired with `AbstractOperation`s. These work much the same way as when they are used for simulation output, but with a bit of boiler-plate code for reading and writing.

## Simple post-processing workflow
Here is an example script that produces speed along with total and mean kinetic energy
```julia
# analysis-example.jl

```

> ### Exercise 3
> Process the field $c$ to produce the mean state $\langle c \rangle$ along with the derived quantities $\int\left (\frac{\partial \langle c \rangle}{\partial z}\right )^2 \text{d}z$, $\int\frac{1}{2}\langle c \rangle^2\text{d}z$ and $\kappa_\text{eff}$ in a new file for each simulation.

Running `tracer.jl` with filenames for the post-processed data as arguments should produce the following figure