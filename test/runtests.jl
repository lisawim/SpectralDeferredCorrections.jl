using Test
using SpectralDeferredCorrections

include("test_core/test_collocation.jl")
include("test_core/test_problem_ode.jl")
include("test_core/test_errors.jl")
include("test_core/test_simulation.jl")
include("test_core/test_step.jl")
include("test_core/test_sweeper.jl")

include("test_problems/test_linear_test.jl")

include("test_simulation/test_simulator.jl")

include("test_sweepers/test_fully_implicit_SDC.jl")
include("test_sweepers/test_newton.jl")
