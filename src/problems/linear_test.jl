module LinearTestEquation

using SpectralDeferredCorrections
using LinearAlgebra
using StaticArrays

using ..ProblemODEBase

import ..ProblemODEBase: f, solve, u_exact

export LinearTestSPP

"""
    LinearTestSPP

Represents a linear singular perturbation problem of the form:

    dy/dt = lamb_diff * y + lamb_alg * z
    dz/dt = 1 / eps * (lamb_diff * y - lamb_alg * z)

for perturbation parameter `eps`.

### Fields

  - `A::AbstractMatrix`: The coefficient matrix defining the linear operator.
  - `eps::AbstractFloat`: The perturbation parameter.
  - `lamb_diff::AbstractFloat`: Parameter from the problem.
  - `lamb_alg::AbstractFloat`: Parameter from the problem.

### Example

```julia
A = [lamb_diff lamb_alg; lamb_diff/eps -lamb_alg/eps]
eps = 1e-3
u0 = [exp(2 * lamb_diff * t), lamb_diff / lamb_alg * exp(2 * lamb_diff * t)]
problem = LinearTestSPP(eps)
```
"""
struct LinearTestSPP <: AbstractProblemODE
    A::SMatrix{2, 2, Float64}
    eps::Float64
    lamb_diff::Float64
    lamb_alg::Float64
    newton_tol::Float64
    newton_maxiter::Int

    function LinearTestSPP(
            eps::Float64;
            lamb_diff::Float64 = 2.0,
            lamb_alg::Float64 = -1.0,
            newton_tol::Float64 = 1e-12,
            newton_maxiter::Int = 20
    )
        A = @SMatrix [lamb_diff lamb_alg; lamb_diff/eps -lamb_alg/eps]
        return new(A, eps, lamb_diff, lamb_alg, newton_tol, newton_maxiter)
    end
end

f(problem::LinearTestSPP, t, u) = problem.A * u

function solve(problem::LinearTestSPP, rhs, t, u0, factor)
    g(u) = u - factor * problem.A * u - rhs
    dg(u) = I - factor * problem.A

    u = newton_vector(g, dg, u0, problem.newton_tol, problem.newton_maxiter)

    return u
end

function u_exact(problem::LinearTestSPP, t)
    if t == 0.0
        return [
            exp(2 * problem.lamb_diff * t),
            problem.lamb_diff / problem.lamb_alg * exp(2 * problem.lamb_diff * t)
        ]
    else
        throw(NotImplementedError("Exact solution is only available at t = 0.0 for this problem."))
    end
end

end
