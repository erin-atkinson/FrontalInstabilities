# The equations of motion 
This section will outline the derivation of the Boussinesq equations in a rotating frame from the equation of motions of an inviscid, incompressible fluid,
$$
\frac{\text{D}\vec u}{\text{D}t} = -\frac{1}{\rho}\nabla p - g\hat z \quad \text{and}\quad \nabla \cdot \vec u = 0. \quad (1)
$$
Where $\vec u = (u, v, w)$ is the velocity, $\rho$ is the density, $p$ is pressure and $g$ is the gravitational acceleration. The Lagrangian derivative $\text{D} / \text{D}t = \partial t / \partial t + \vec u \cdot \nabla$ is the rate of change of a property of a fluid parcel and the coordinate system is such that $+z$ is aligned with the vertical (away from the  centre of the Earth). We will also briefly introduce the role of density fronts in the ocean, and how idealized studies of fronts, such as the one we will simulate later, may be constructed.

This section is intended for recap and as a theoretical context for the main, simulation component of the module.  Those familiar with the primitive equations for ocean flow may skip it, and those who just want to start doing some simulations may skim this and the following section.

## Fluid in a rotating frame
Observers at a fixed point relative to the surface of the Earth rotate with it. This is not an inertial frame, and Newton's second law doesn't apply in its unmodified form. Those familiar with solid body mechanics will recall that, for an inertial frame $I$ and frame $R$ rotating at a constant angular velocity $\vec \Omega = \Omega \hat n$ the rate of change of of a vector in the two frames are related by
$$
\frac{\text{d}}{\text{d}t}_I = \frac{\text{d}}{\text{d}t}_R + \vec \Omega \times
$$
Applying this twice to the position of a fluid parcel $\vec x$, we can form Newton's second law
$$
\frac{\text{d}^2\vec x}{\text{d}t^2}_I = \left (\frac{\text{d}}{\text{d}t}_R + \vec \Omega \times\right )\left (\frac{\text{d}}{\text{d}t}_R + \vec \Omega \times \right)\vec x = \vec F
$$
Which gives two inertial forces
$$
\frac{\text{d}^2\vec x}{\text{d}t^2}_I = \frac{\text{d}^2\vec x}{\text{d}t^2}_R + 2\vec{\Omega} \times \vec u - \Omega^2(\vec x - \vec x \cdot \hat n \,\hat n)
$$
The last term is the centrifugal acceleration, which is well known. This is directed perpendicularly away from the rotational axis and can be absorbed into the gravitational potential with little fuss. The middle term is the Coriolis acceleration. At all but the largest scales, the spherical geometry of the Earth can be ignored and we can work in a coordinate system with $\hat z$ aligned with the local vertical direction and $\hat y$ aligned with north-south. 

In this coordinate system, the Coriolis acceleration can be written
$$
2\vec{\Omega} \times \vec u = 2\Omega \begin{pmatrix}0 \\ \cos \lambda \\ \sin \lambda \end{pmatrix} \times \begin{pmatrix}u \\ v \\ w \end{pmatrix} = 2\Omega \begin{pmatrix} -v\sin \lambda  + w \cos \lambda \\ u\sin \lambda \\ -u \cos \lambda \end{pmatrix}.
$$

In most geophysical applications, gravity is strong compared to rotation ($2\Omega u\cos \lambda \ll g$) and vertical velocities are small ($w\cos \lambda \ll v\sin\lambda$). We can then apply the so-called _traditional approximation_:
$$
2\vec{\Omega} \times \vec u \approx 2\Omega \begin{pmatrix} -v\sin \lambda   \\ u\sin \lambda \\ 0 \end{pmatrix} = f \hat z \times \vec u \quad \text{where} \quad f = 2\Omega \sin\lambda \sim 10^{-4}\,\text{s}.
$$
We can add the Coriolis acceleration to the momentum equation to account for the effect of rotation
$$
\frac{\text{D}\vec u}{\text{D}t} + f \hat z \times \vec u= -\frac{1}{\rho}\nabla p - g\hat z
$$
When is rotation important? If we assume that the timescale of a flow is advective $T \sim L/U$ for velocity scale $U$ and horizontal length scale $L$, then the relative size of the first two terms is
$$
\frac{{\text{D}\vec u}/{\text{D}t}}{f \hat z \times \vec u} \sim \frac{\frac{U^2}{L}}{fU} = \frac{U}{fL}
$$
This is the Rossby number $\text{Ro} = U / fL$. The effect of rotation is greater when $\text{Ro}$ is small. For ocean flow, which is typically $U \sim 0.1 - 1\,\text{m}\,\text{s}^{-1}$ and at mid-latitudes, rotation dominates the momentum equation for flow structures with 
$$
L \gg \frac{1\,\text{m}\,\text{s}^{-1}}{10^{-4}\,\text{s}} = 10 \,\text{km}
$$
So, away from the equator where $f \approx 0$, rotation is the most important component of the acceration of a fluid parcel at many scales of interest for oceanography. Flow in this rotation-dominated regime is called _geostrophic_. Geostrophy can be a strong constraint on the possible motion of a fluid, and much understanding has been gleaned by studying the behaviour of models built on approximations to the equations of motion valid for $\text{Ro}\to 0$


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
\rho_0 \frac{\text{D}\vec u_1}{\text{D}t} = -\nabla \delta p- \delta \rho g\hat z.
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
$$b_0 = N^2z + M^2 x \quad \text{and} \quad v_0  = Sz= \frac{M^2}{f} z,$$
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
