# Instability in the SE equations
The dispersion relationship for waves in the hydrostatic double-periodic ideal front equations is
$$
\omega^2 = f(f + \zeta) + \frac{1}{m^2}\left (N^2k^2 - 2M^2km\right ) \quad (1)
$$
with $\zeta = \frac{\partial v_0}{\partial x}$. Instability (modes with $\omega^2 < 0$) can clearly occur for $f(f + \zeta) < 0$ or $N^2 < 0$. These are inertial and gravitational instabilities respectively and will not be the focus of this example. Even if those two conditions are met, a sufficiently large $M^2$ can cause symmetric instability, which consists of thin rolls aligned with isopycnals (lines of constant $b_0$) in the hydrostatic case and with no variation in the down-front (y) direction, hence the name. 

Symmetric instability has some quirks which may be of interest
 - When treated with care in a bounded domain, the growth rate can be shown to be maximized for modes with $k \to \infty$ (Stone 1966)
 - Correct treatment for deep/non-hydrostatic flows requires non-traditional effects ($f \not\propto \hat z$) (Zeitlin 2018)
 - The full evolution is quite sensitive to details of the viscosity/diffusivity, even if they are very small
 - Its stability parameter is materially conserved (see exercise)

> ### Exercise 1
> For positive $f$, show that the condition for stability in equation (1) is that the potential vorticity $q$ is negative where $$q = (\nabla \times \vec u_0 + f\hat z) \cdot \nabla b_0 = (f + \zeta)N^2 - \frac{M^4}{f}$$ 
> Potential vorticity is typically thought of as a materially conserved property ($\text{D}q/\text{D}t=0$, see Vallis $\S 4.5$) and this is true for the form of the Boussinesq equations presented previously. This presents a problem: an unstable fluid parcel with $q<0$ will remain unstable to SI no matter how much it evolves. What may resolve this contradiction?

For $\zeta = 0$, the stability of a fluid to SI is controlled by a single non-dimensional number
$$
q = fN^2\left (1 - \frac{M^4}{N^2f^2}\right ) = fN^2\left (1 - \frac{S^2}{N^2}\right ) = fN^2 \left ( 1- \frac{1}{\text{Ri}}\right) \quad \text{with} \quad \text{Ri} = \frac{N^2}{S^2}
$$
The Richardson number $\text{Ri}$ is the ratio of fluid stratification to vertical shear of velocity. Sheared velocities are inherently unstable, and one of the first type of fluid instability one learns about (Kelvin-Helmholtz). However, fluid with a large Richardson number, like most large-scale ocean flows, is very well-supported by gravity - low density on top of much higher density - which counteracts the destabilising effect of velocity shear. Symmetric instability occurs for $\text{Ri} < 1$.

Finally, we are ready to proceed with the fun part of the module. A rough outline of the remaining content is as follows

1. Simulate a simple state with a known Richardson number
2. Inspect the resulting instability by creating an animation
3. Repeat for other values of $\text{Ri}$
4. Compare the consequences of the instability as $\text{Ri}$ changes, focusing on factors important to large-scale ocean simulations