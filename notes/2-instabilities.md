# Instability in the SE equations
## Hydrostatic mode analysis
With the ansatz $\psi \propto \exp(i\omega t + ikx + imz)$, the dispersion relation for waves in the doubly-periodic _hydrostatic_ SE equation is
$$
\omega^2 = f(f + \zeta) + \frac{1}{m^2}\left (N^2k^2 - 2S fkm\right )
$$
Instability can clearly occur for $f(f + \zeta) < 0$ or $N^2 < 0$. These are inertial and gravitational instabilities respectively and will not be the focus of this example.

## Symmetric instability
A re-arrangement leads to 
Symmetric instability has some quirks which may be of interest
 - When treated with care in a bounded domain, the growth rate can be shown to be maximized for modes with $k \to \infty$ (Stone 1966)
 - Correct treatment for deep/non-hydrostatic flows requires non-traditional effects ($f \not\propto \hat z$) (Zeitlin 2018)
 - The full evolution is quite sensitive to details of the viscosity/diffusivity, even if they are very small
 - Its stability parameter is materially conserved

> ### Exercise 1
> Show that the condition for stability in equation (1) is that the potential vorticity $q$ is negative where $$q = (\nabla \times \vec u + f\hat z) \cdot \nabla b.$$ Potential vorticity is typically thought of as a materially conserved property ($\text{D}q/\text{D}t=0$, see Vallis $\S 4.5$) and this is true for the form of the Boussinesq equations presented previously. This presents a problem: an unstable fluid parcel with $q<0$ will remain unstable to SI no matter how much it evolves. What may resolve this contradiction?

> ### Exercise 2
> Using the form of the Sawyer Eliassen equations derived in the previous section, what is the dispersion relationship for non-hydrostatic modes? Is the stability condition or the slope unchanged?