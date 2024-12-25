using Test
using SpectralDeferredCorrections

@testset "AbstractSweeper Tests" begin
    struct DummySweeper <: AbstractSweeper end

    struct DummyProblem <: AbstractProblemODE end

    sweeper = DummySweeper()
    problem = DummyProblem()

    @test_throws NotImplementedError predict_values(problem, sweeper)

    @test_throws NotImplementedError update_nodes(problem, sweeper)

    @test_throws NotImplementedError compute_residual(problem, sweeper)

    @test_throws NotImplementedError compute_last_node(problem, sweeper)
end