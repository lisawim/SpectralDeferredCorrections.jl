using Test
using SpectralDeferredCorrections
import .AbstractProblem


include("test_core/test_abstract_problem.jl")

include("test_problems/test_linear_test.jl")

include("test_sweepers/test_newton.jl")
