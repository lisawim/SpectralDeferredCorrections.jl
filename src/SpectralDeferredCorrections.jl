module SpectralDeferredCorrections

"""
A simple function that adds two numbers.
"""
add_numbers(a::Number, b::Number) = a + b

# Include core and problem files
include("core/abstract_problem.jl")
include("problems/linear_test.jl")

using .AbstractProblem
using .LinearTestEquation

export AbstractDifferentialProblem
export LinearTestSPP, initialize_problem, f, u_exact
export add_numbers

end
