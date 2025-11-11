# The equations of motion 
This section will outline the derivation of the Boussinesq equations in a rotating frame from the equation of motions of an inviscid, incompressible fluid,
$$
\frac{\text{D}\vec u}{\text{D}t} = -\frac{1}{\rho}\nabla p - g\hat z \quad \text{and}\quad \nabla \cdot \vec u = 0. \quad (1)
$$
Where $\vec u = (u, v, w)$ is the velocity, $\rho$ is the density, $p$ is pressure and $g$ is the gravitational acceleration. The coordinate system is such that $z$ is aligned with the vertical (away from the centre of the Earth). 

## Fluid in a rotating frame

## The Boussinesq approximation
Water is mostly incompressible, so the density of sea water depends primarily on its temperature and salt content, with an average of about $\rho_0 = 1027\,\text{kg}\,\text{m}^{-3}$. Especially near the surface of the ocean, density changes are small, with an upper range of about $\delta \rho \sim 10 \,\text{kg}\,\text{m}^{-3}$. We may therefore seek an approximation of $(1)$ that is appropriate in this case. Expanding in the small parameter $\varepsilon$ around a static state ($\vec u_0 = 0$)
$$
\vec u = \varepsilon\vec u_1 + \dots \quad \text{and} \quad \rho = \rho_0 + \varepsilon \delta \rho + \dots \quad \text{and} \quad p = p_0 + \varepsilon \delta p + \dots,
$$
the momentum equation becomes
$$
\varepsilon(\rho_0 + \varepsilon \delta \rho)\frac{\text{D}\vec u_1}{\text{D}t} = -\nabla (p_0 + \varepsilon \delta p) - (\rho_0 + \varepsilon \delta \rho) g\hat z
$$
Equating the zero-order terms gives
$$
0 = - \nabla p_0 - \rho_0 g \hat z \implies p_0 = -\rho_0 g z
$$
Which is just the hydrostatic relation for a constant density fluid. The next order equation is
$$
\rho_0 \frac{\text{D}\vec u_1}{\text{D}t} = -\nabla \delta p_1 - \delta \rho_1 g\hat z.
$$
We usually define a geopotential $\phi = \delta p/\rho_0$ and buoyancy $b = -\delta\rho g /\rho_0$ to get the Boussinesq equations.
$$
\frac{\text{D}\vec u}{\text{D}t} = -\nabla \phi + b\hat z \quad \text{and}\quad \nabla \cdot \vec u = 0.
$$
These model the flow of an almost-constant density, incompressible fluid. An equation for $b$ is required, which is derived from the equation of state for sea water. Typically, buoyancy is materially conserved just as temperature and salinity are:
$$
\frac{\text{D}b}{\text{D}t} = 0,
$$
though this is not true in the case of a compressible fluid (flow speed comparable to speed of sound, or large hydrostatic pressure variations) or in the presence of sources of temperature or salinity. 

## Primitive equations
Combining rotation and the Boussinesq approximation, we arrive at the primitive equations for incompressible, inviscid ocean flow in the absence of sources of momentum and buoyancy
$$
\frac{\text{D}\vec u}{\text{D}t} + f \hat z \times \vec u = -\nabla \phi + b\hat z,\quad \frac{\text{D}b}{\text{D}t} = 0 \quad \text{and}\quad \nabla \cdot \vec u = 0.
$$
This set of equations describes a great deal of ocean phenomena, and may be applicable to thin horizontal slices of the atmosphere also.

> ### Exercise 1
>
> Show that, for a fluid with $\frac{\text{D}\vec u}{\text{D}t} = 0$, the thermal wind relations are satisfied
> $$
f\frac{\partial u}{\partial z} = -\frac{\partial b}{\partial y}, \quad f\frac{\partial v}{\partial z} = \frac{\partial b}{\partial x} % \quad \text{or}\quad f\hat z\times \frac{\partial \vec u_H}{\partial z} = \nabla_H b
> $$
> The component of the flow that satisfies this relationship is called the _balanced_ flow. At large, geostrophic scales, most of the flow is balanced and this relationship can be used to infer information about the flow from knowledge of its density gradients.

# Ocean fronts
Fronts are highly anisotropic structures consisting of a horizontal change in density. In the open ocean, they are primarily created at the edges of large-scale vortices, or seperating boundary currents like the Gulf Stream or Kuroshio current. They can also be created at coasts, such as by fresh water inflow due to rivers.

An important feature of fronts, especially at smaller $\text{Ro} \sim 1$ scales, is the secondary circulation that forms due to the effect of the background flow or forcing by winds or cooling at the ocean surface. This circulation transports fluid around the front and is responsible for an intense vertical transport of heat, carbon and nutrients. 

Strong fronts may also be susceptible to instabilities. In this module we will explore the evolution of such a front and the consequences of instability for the vertical transport of fluid properties.

## Describing an ideal front
An ideal front may be described by an Eady state, with constant horizontal and vertical buoyancy gradients, as well as a balanced thermal wind jet,
$$b_0 = N^2z + M^2 x \quad \text{and} \quad v_0 = \frac{M^2}{f} z,$$
where we assume that $v_0 = 0$ on $z=0$.

## Flow around an ideal front
The total flow is the sum of the front itself and any perturbations
$$
\vec u_\text{tot} = v_0\hat y + \vec u  \quad b_\text{tot} = b_0 + b\quad \phi_\text{tot}= \int_0^z b_0(x, s) \,\text{d}s + \phi \quad  (2)
$$
We can substitute these into the Boussinesq equations for $(\vec u_\text{tot} , b_\text{tot} )$ to get
$$
\frac{\text{D}\vec u}{\text{D}t} + f \hat z \times \vec u = -\nabla \phi + b\hat z - \frac{M^2}{f}w\hat y,\quad \frac{\text{D}b}{\text{D}t} = - N^2 w - M^2 u\quad \text{and}\quad \nabla \cdot \vec u = 0. \quad (3)
$$
We will simulate these equations to produce a solution for $(\vec u, b)$ we can then recover the total flow using $(2)$
