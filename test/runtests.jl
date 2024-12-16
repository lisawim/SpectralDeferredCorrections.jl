using Test
using SpectralDeferredCorrections

include("test_core/test_problem_ode.jl")
include("test_core/test_errors.jl")

include("test_problems/test_linear_test.jl")

include("test_sweepers/test_newton.jl")
