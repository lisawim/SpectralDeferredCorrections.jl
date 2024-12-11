module LinearTestEquation

using ..AbstractProblem
using ..Errors

export LinearTestSPP, u_exact

"""
    LinearTestSPP

Represents a linear singular perturbation problem of the form:

    dy/dt = 2.0 * y - 1.0 * z
    dz/dt = 1 / eps * (2.0 * y + 1.0 * z)

for perturbation parameter `eps`.

### Fields
- `A::AbstractMatrix`: The coefficient matrix defining the linear operator.
- `eps::AbstractFloat`: The perturbation parameter.
- `u0::AbstractVector`: The initial condition at `t0`.

### Example
```julia
A = [lamb_diff lamb_alg; lamb_diff / eps -lamb_alg / eps]
eps = 1e-3
u0 = [exp(2 * lamb_diff * t), lamb_diff / lamb_alg * np.exp(2 * lamb_diff * t)]
problem = LinearTestSPP(A, eps, u0)
"""
struct LinearTestSPP <: AbstractProblem.AbstractDifferentialProblem
    A::AbstractMatrix
    eps::AbstractFloat
    u0::AbstractVector
end

function AbstractProblem.f(problem::LinearTestSPP, t, u)
    return problem.A * u
end

# Implement the exact solution function
function AbstractProblem.u_exact(problem::LinearTestSPP, t)
    if t == 0.0
        return problem.u0
    else
        throw(Errors.NotImplementedError("Exact solution is only available at t = 0.0 for this problem."))
    end
end

function AbstractProblem.initialize_problem(::Type{LinearTestSPP}, eps, t0)
    lamb_diff = 2.0
    lamb_alg = -1.0

    A = [lamb_diff lamb_alg; lamb_diff / eps -lamb_alg / eps]
    u0 = [exp(2 * lamb_diff * t0), lamb_diff / lamb_alg * exp(2 * lamb_diff * t0)]
    return LinearTestSPP(A, eps, u0)
end

end
