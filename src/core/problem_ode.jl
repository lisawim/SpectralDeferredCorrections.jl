module ProblemODEBase

using ..Errors

export AbstractProblemODE, f, solve, u_exact

"""
    AbstractProblemODE

An abstract type representing a general differential problem, such as an ODE, PDE, or DAE.

### Subtypes

All concrete problem types must subtype `AbstractProblemODE` and implement the following methods:

  - `f(problem::AbstractProblemODE, t, y)`: Defines the right-hand side of the differential equation.
  - `u_exact(problem::AbstractProblemODE, t)`: Returns the exact solutions, if available.
  - `initialize_problem(::Type{<:AbstractProblemODE})`: Initializes a problem.
"""
abstract type AbstractProblemODE end

function f(problem::AbstractProblemODE, t, u)
    throw(NotImplementedError("Right-hand side function must be implemented."))
end

function solve(problem::AbstractProblemODE, rhs, t, u0, factor)
    throw(NotImplementedError("Solve routine must be provided."))
end

function u_exact(problem::AbstractProblemODE, t)
    throw(NotImplementedError("Initial condition must be provided."))
end

end
