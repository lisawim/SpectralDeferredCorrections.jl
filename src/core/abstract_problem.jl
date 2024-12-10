module AbstractProblem

export AbstractDifferentialProblem, f, u_exact

"""
    AbstractDifferentialProblem

An abstract type representing a general differential problem, such as an ODE, PDE, or DAE.

### Subtypes
All concrete problem types must subtype `AbstractDifferentialProblem` and implement the following methods:

- `f(problem::AbstractDifferentialProblem, t, y)`: Defines the right-hand side of the differential equation.
- `u_exact(problem::AbstractDifferentialProblem, t)`: Returns the exact solution, if available.
- `initialize_problem(::Type{<:AbstractDifferentialProblem})`: Initializes a problem.
"""
abstract type AbstractDifferentialProblem end

# Interface functions to be implemented by all problems
function f(problem::AbstractDifferentialProblem, t, u)
    throw(NotImplementedError("Right-hand side function must be implemented."))
end

function u_exact(problem::AbstractDifferentialProblem, t)
    throw(NotImplementedError("Initial condition must be provided."))
end

function initialize_problem(::Type{<:AbstractDifferentialProblem}, t)
    throw(NotImplementedError("Initialization must be implemented."))
end

end
