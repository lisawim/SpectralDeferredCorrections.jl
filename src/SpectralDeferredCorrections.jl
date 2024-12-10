module SpectralDeferredCorrections

"""
A simple function that adds two numbers.
"""
add_numbers(a::Number, b::Number) = a + b

# Include core files
#include("core/abstract_problem.jl")
#include("core/errors.jl")

# Include problem files
#include("problems/linear_test.jl")

# Include core modules
include(joinpath(@__DIR__, "core/errors.jl"))
include(joinpath(@__DIR__, "core/abstract_problem.jl"))

# Include problem files
include(joinpath(@__DIR__, "problems/linear_test.jl"))

using .AbstractProblem
using .Errors
using .LinearTestEquation

export AbstractDifferentialProblem
export LinearTestSPP, initialize_problem, f, u_exact
export NotImplementedError
export add_numbers

end
