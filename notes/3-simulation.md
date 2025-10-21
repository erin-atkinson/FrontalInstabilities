# A simulation of a front
## Basic Oceananigans setup
## An ideal front
$$
b_0(x, z) = \frac{\Delta b}{2}\tanh \left(\frac{x \cos \theta + z \sin \theta}{\ell}\right)
$$
$$
v_0(x, z) = \frac{1}{f}\int_{0}^z \frac{\partial }{\partial x}b_0(x, s)\text{d}s = \frac{b_0(x, z) - b_0(x, 0)}{f\tan{\theta}}
$$
We wish to focus on fronts which are unstable to symmetric instability. This requires that $N^2 ≥ 0$ and $\frac{\partial v_0}{\partial x} \geq -f$ everywhere. The former is satisfied for positive $\theta$. 
> ### Exercise
> 
> Derive an expression for the Richardson number $\text{Ri} = N^2 / S^2$ of the basic state above. Stone (1966) demonstrates that, for an Eady state with $\text{Ro} = 0$, Kelvin-Helmholtz instability is dominant for $\text{Ri} \leq 0.25$. Assuming that this relationship may be used here, what condition on $(\Delta b, \theta, f, \ell)$ ensures that Kelvin-Helmholtz instability is avoided?
