module AbstractProblem

using ..Errors

export AbstractDifferentialProblem, f, solve, u_exact

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

function f(problem::AbstractDifferentialProblem, t, u)
    throw(NotImplementedError("Right-hand side function must be implemented."))
end

function solve(problem::AbstractDifferentialProblem, rhs, t, u0, factor)
    throw(NotImplementedError("Solve routine must be provided."))
end

function u_exact(problem::AbstractDifferentialProblem, t)
    throw(NotImplementedError("Initial condition must be provided."))
end

end
