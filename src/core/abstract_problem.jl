module AbstractProblem

export AbstractDifferentialProblem, f, y0, initialize_problem

# Abstract type for all differential problems
abstract type AbstractDifferentialProblem end

# Interface functions to be implemented by all problems
function f(problem::AbstractDifferentialProblem, t, y)
    throw(NotImplementedError("Right-hand side function must be implemented."))
end

function u_exact(problem::AbstractDifferentialProblem, t)
    throw(NotImplementedError("Initial condition must be provided."))
end

function initialize_problem(::Type{<:AbstractDifferentialProblem}, tspan)
    throw(NotImplementedError("Initialization must be implemented."))
end

end
