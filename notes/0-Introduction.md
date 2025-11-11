# Introduction
This is a module designed for the NSERC CREATE grant _Training for novel directions in quantitative climate science_. 

The ocean is awash with important fluid dynamical processes at all spatial and temporal scales. 

In this module we will create a simulation of flow around a submesoscale ocean front using Oceananigans, a Julia package for finite-difference simulations of the Boussinesq equations, intended for an oceanic context. The setup is motivated by the theory of symmetric instability, an instability in rotating, baroclinic fluids that is important in the submesoscale ocean.

The module will assume basic familiarity with fluid dynamics fundamentals and the incompressible Navier-Stokes equations. Proficiency in Julia is not required, the language should be intuitive for those with experience in Python (numpy) or MATLAB. An outline of this module is as follows:

0. Julia setup for Oceananigans and GLMakie
1. Derivation of the Boussinesq equations and subsequently the Sawyer-Eliassen equations for the flow in the frontal plane
2. Instabilities in the Sawyer-Eliassen equations
3. Setting up a simulation
4. Visualization
5. Analysis and post-processing

# Setup
For those familiar with Julia, this module will use the latest version of Julia 1.10 (1.10.10 as of writing) and the `Project.toml` file will consist of the packages
```
  [e9467ef8] GLMakie v0.12.0
  [9e8cae18] Oceananigans v0.100.6
```
To keep setup as simple as possible, this module does not use computational notebooks or assume you have an IDE set up for Julia.  Those new to Julia can follow the instructions below to install and configure it.

## Installing Julia
Installation instructions are available at https://julialang.org/install/. The recommended method is to install `juliaup` which is a command-line utility. Then you should be able to run it from the terminal
```bash
juliaup
```
We would like to use Julia 1.10, just do `juliaup add 1.10` to download the latest version. Once this is done, type `julia` to enter the REPL:
![A screenshot of the Julia REPL](../images/REPL.png)
Documentation is available at https://docs.julialang.org/en/v1/manual/getting-started/. This module will not require advanced knowledge of Julia. Make sure you are comfortable with

- Assigning and using variables
- Creating `Tuple`s and `NamedTuple`s with `(a, b)` and `(; a, b = 42)`, for instance
- Defining functions with a `function` block and assignment form `f(x) = x^2`
- Control flow with `if`
- `for` loops
- Operations on arrays, broadcasting
- Specifically for simulations: ensuring hygenic variable scope (avoiding global variables)

Play around! Julia is simple to learn if coming from other common scientific languages. They even provide a helpful reference for important differences to others: https://docs.julialang.org/en/v1/manual/noteworthy-differences/

It is useful to make scripts, conventionally a `.jl` file extension. These can be run from the terminal with
```bash
julia -t 4 path/to/script.jl
```
Note the optional `-t` argument. This is the number of threads that Julia should use. It defaults to one, but simulations will greatly benefit from multithreading, so I suggest using as many as your computer has available (use 4 if you are unsure) when running simulation code.

## Adding Oceananigans and GLMakie
Julia comes with its own package manager, all you have to do it run Julia to access the REPL then type `]`:
![The Julia package manager](../images/pkg.png)
Now we can install the required packages:
- `Oceananigans` is the Boussinesq equation simulator we are using
- `GLMakie` is for producing plots

To install the versions used in this module, use `@`. If you would like to use the latest compatible versions, simply remove the version specification `@a.b.c`, though beware there may be differences.
```
add Oceananigans@0.100.6 GLMakie@0.12.0
```
Then they will be installed:
![Installing packages](../images/installingpackages.png)

This will take a while, but it will aim to install the above packages and all their dependencies. Packages you explicitly install like above become part of your `Project.toml` and can be viewed with `status` and accessed in scripts with `using`. All of their dependencies are part of your `Manifest.toml` and these can be viewed with `status -m`. The `status` of my test environment looks like
![Example status](../images/status.png)
