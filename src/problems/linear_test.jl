module LinearTestEquation

using ..AbstractProblem

export LinearTestSPP, initialize_problem

struct LinearTestSPP <: AbstractProblem.AbstractDifferentialProblem
    A::AbstractMatrix
    tspan::Tuple
    u0::AbstractVector
end

function AbstractProblem.f(problem::LinearTestSPP, t, u)
    return problem.A * u
end

function AbstractProblem.u_exact(problem::LinearTestSPP, t)
    if t == 0.0
        return problem.u0
    else
        throw(NotImplementedError("Exact solution is only available at t = 0.0 for this problem."))
    end
end

function initialize_problem(::Type{LinearTestSPP}, eps, tspan)
    lamb_diff = 2.0
    lamb_alg = -1.0

    A = [lamb_diff lamb_alg; lamb_diff / eps -lamb_alg / eps]
    u0 = [exp(2 * lamb_diff * t), lamb_diff / lamb_alg * np.exp(2 * lamb_diff * t)]
    return TestEquation0D(A, tspan, u0)
end

end
