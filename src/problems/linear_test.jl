module LinearTestEquation

using ..AbstractProblem
using ..Errors

export LinearTestSPP, u_exact

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
A = [lamb_diff lamb_alg; lamb_diff / eps -lamb_alg / eps]
eps = 1e-3
u0 = [exp(2 * lamb_diff * t), lamb_diff / lamb_alg * exp(2 * lamb_diff * t)]
problem = LinearTestSPP(eps)
"""
struct LinearTestSPP <: AbstractProblem.AbstractDifferentialProblem
    A::AbstractMatrix
    eps::AbstractFloat
    lamb_diff::AbstractFloat
    lamb_alg::AbstractFloat

    function LinearTestSPP(eps::Float64)
        lamb_diff = 2.0
        lamb_alg = -1.0

        A = [lamb_diff lamb_alg; lamb_diff / eps -lamb_alg / eps]

        return new(A, eps, lamb_diff, lamb_alg)
    end
end

function AbstractProblem.f(problem::LinearTestSPP, t, u)
    return problem.A * u
end

# Implement the exact solution function
function AbstractProblem.u_exact(problem::LinearTestSPP, t)
    if t == 0.0
        return [
            exp(2 * problem.lamb_diff * t),
            problem.lamb_diff / problem.lamb_alg * exp(2 * problem.lamb_diff * t)
        ]
    else
        throw(Errors.NotImplementedError("Exact solution is only available at t = 0.0 for this problem."))
    end
end

end
