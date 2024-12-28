using SafeTestsets
using SpectralDeferredCorrections

@time begin
    @time @safetestset "Collocation Tests" begin
        include("test_core/test_collocation.jl")
    end
    @time @safetestset "AbstractProblemODE Tests" begin
        include("test_core/test_problem_ode.jl")
    end
    @time @safetestset "Errors Tests" begin
        include("test_core/test_errors.jl")
    end
    @time @safetestset "AbstractSimulator Tests" begin
        include("test_core/test_simulation.jl")
    end
    @time @safetestset "Step and ConvergenceState Tests" begin
        include("test_core/test_step.jl")
    end
    @time @safetestset "AbstractSweeper Tests" begin
        include("test_core/test_sweeper.jl")
    end

    @time @safetestset "LinearTestSPP Tests" begin
        include("test_problems/test_linear_test.jl")
    end

    @time @safetestset "Simulator Tests" begin
        include("test_simulation/test_simulator.jl")
    end

    @time @safetestset "FullyImplicitSDC Tests" begin
        include("test_sweepers/test_fully_implicit_SDC.jl")
    end
    @time @safetestset "Newton Tests" begin
        include("test_sweepers/test_newton.jl")
    end
end
