# Instability in a front

We now turn to motions that evolve on time scales much longer than $N^{-1}$.

> ### Exercise 2.1
> 
> A. Using the equation for $\text{D}w/\text{D}t$, show that, under the condition highlighted above, one can neglect the vertical acceleration of perburbations. What is this approximation called?
>
> B. Using this approximation, show that equation set $1.3$ may be written, keeping only linear terms and ignoring $y$ variation, as
> $$\frac{\partial u}{\partial t} - fv = -\phi_x, \quad \frac{\partial v}{\partial t} + fu = -\zeta u-\frac{M^2}{f}w$$
> $$\text{and} \quad \frac{\partial b}{\partial t}= -M^2 u-N^2w,$$
> with $\phi_z = b$ and $\nabla \cdot \vec u = 0$.
> 
> C. Show that a plane-wave mode $(u, v, w, b) = (\tilde u, \tilde v, \tilde w, \tilde b)\exp[\text i(kx + mz - \omega t)]$ evolving in an infinitely long domain follows the dispersion relationship
> 
> $$\omega^2 = f(f + \zeta) + \frac{1}{m^2}\left (N^2k^2 - 2M^2km\right ) \qquad (2.1)$$
> 
> Hint: construct a differential equation for $u$ only, then use the plane wave assumption.
>
Instability (i.e., modes with $\omega^2 < 0$) can clearly occur for $f(f + \zeta) < 0$ or $N^2 < 0$. These are inertial and gravitational instabilities respectively and will not be the focus of this example. Even if those two conditions are not met, a sufficiently large $M^2$ can produce a third form of instability.

> ### Exercise 2.2
> A: For positive $f$, show that the condition for stability in equation ${(2.1)}$ is that the potential vorticity $q$ is positive, where
> 
> $$q = (\nabla \times \vec u_0 + f\hat z) \cdot \nabla b_0 = (f + \zeta)N^2 - \frac{M^4}{f}.$$
> 
> What is the relationship between $k$ and $m$ for the most unstable plane-wave mode?
>
> Hint: a plane wave perturbation is stable if it has $\omega^2 > 0$, so find the condition for this to be satisfied for all possible plane waves.
>
> B: Using the previous result, show that
> $${\begin{pmatrix}\tilde u \\ \tilde v \\ \tilde w\end{pmatrix} \cdot \nabla b_0 = 0.}$$
> Hence sketch the flow due to the most unstable mode.

Symmetric instability consists of thin rolls aligned with isopycnals (lines of constant $b_0$) in the hydrostatic case and with no variation in the down-front ($y$) direction, hence the name. Symmetric instability has some quirks which may be of interest
 - When treated with care in a bounded domain, the growth rate can be shown to be maximized for modes with $k \to \infty$ (Stone 1966)
 - Correct treatment for deep/non-hydrostatic flows requires non-traditional effects (${\vec \Omega \not\parallel \hat{z}}$) (Zeitlin 2018)
 - The full evolution is quite sensitive to details of the viscosity/diffusivity, even if they are very small.
 - Its stability parameter, $q$, is materially conserved if fluid parcels conserved momentum and buoyancy.

> ### Exercise 2.3
> Potential vorticity is typically thought of as a materially conserved property ($\text{D}q/\text{D}t=0$, see Vallis $`\S\,4.5`$) and this is true for the inviscid Boussinesq equations $(1.2)$ presented previously. This presents a problem: an unstable fluid parcel with $q<0$ will remain unstable to SI no matter how much perturbations attempt to restore the fluid to a stabile state. What may resolve this contradiction?
>

For $\zeta = 0$, the stability of a fluid to SI is controlled by a single non-dimensional number, namely,

$$q = fN^2\left (1 - \frac{M^4}{N^2f^2}\right ) = fN^2\left (1 - \frac{S^2}{N^2}\right )\\ = fN^2 \left ( 1- \frac{1}{\text{Ri}}\right) \quad \text{with} \quad \text{Ri} = \frac{N^2}{S^2}.$$

The Richardson number $\text{Ri}$ is the ratio of fluid stratification to vertical shear of velocity. Instability due to a velocity shear is one of the first type of fluid instability one learns about (e.g. Kelvin-Helmholtz). However, fluid with a large Richardson number, like that of most large-scale ocean flows, is very well-supported by gravity -- low density on top of much higher density -- which counteracts the destabilising effect of velocity shear if $\text{Ri} > 0.25$. Symmetric instability is the dominant instability for background flows with $0.25 < \text{Ri} < 1$ (Stone 1966).

Finally, we are ready to proceed with the fun part of the module. A rough outline of the remaining content is as follows.

1. Simulate a simple state with a known Richardson number.
2. Inspect the resulting instability by creating an animation.
3. Repeat for other values of $\text{Ri}$.
4. Compare the consequences of the instability as $\text{Ri}$ changes, focusing on factors important to large-scale ocean simulations.
