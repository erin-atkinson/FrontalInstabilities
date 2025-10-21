# Introduction
This is a module designed for the NSERC CREATE grant _Training for novel directions in quantitative climate science_. 

The ocean is awash with important fluid dynamical processes at all spatial and temporal scales. 

In this module we will create a simulation of flow around a submesoscale ocean front using Oceananigans, a Julia package for finite-difference simulations of the Boussinesq equations, intended for an oceanic context.

The module will assume basic familiarity with fluid dynamics fundamentals and the incompressible Navier-Stokes equations. Proficiency in Julia is not required and should be intuitive for those with experience in Python (numpy) or MATLAB. An outline of this module is as follows:

- Julia setup for Oceananigans and GLMakie (plotting software)
- Derivation of the Boussinesq equations and subsequently the Sawyer-Eliassen equations for the flow in the frontal plane
- Instabilities in the Sawyer-Eliassen equations
- Setting up a simulation
- Visualization
- Analysis and post-processing

# Setup
For those familiar with Julia, this module will use the latest version of Julia 1.10 (1.10.10 as of writing) and the `Project.toml` file will consist of the packages
```
  [5a033b19] CurveFit v0.6.1
  [e9467ef8] GLMakie v0.12.0
  [9e8cae18] Oceananigans v0.100.6
```

Those new to Julia can follow the instructions below.
## Installing Julia
Installation instructions are available at https://julialang.org/install/. The recommended method is to install `juliaup` which is a command-line utility. Then you should be able to run it from the terminal
```bash
> juliaup
The Julia Version Manager

Usage: juliaup <COMMAND>

Commands:
  default      Set the default Julia version
  add          Add a specific Julia version or channel to your system. Access via `julia +{channel}` e.g. `julia +1.6`
  link         Link an existing Julia binary or channel to a custom channel name
  list         List all available channels
  override     Manage directory overrides
  update       Update all or a specific channel to the latest Julia version
  remove       Remove a Julia version from your system
  status       Show all installed Julia versions
  gc           Garbage collect uninstalled Julia versions
  config       Juliaup configuration
  self         Manage this juliaup installation
  completions  Generate tab-completion scripts for your shell
  help         Print this message or the help of the given subcommand(s)

Options:
  -h, --help     Print help
  -V, --version  Print version

To launch a specific Julia version, use `julia +{channel}` e.g. `julia +1.6`.
Entering just `julia` uses the default channel set via `juliaup default`.
```
We would like to use Julia 1.10, just do `juliaup add 1.10`
## Adding Oceananigans and GLMakie
