using Test
using SpectralDeferredCorrections

@testset "Step - check initialization" begin
    prob = LinearTestSPP(1.0)
    sweeper = FullyImplicitSDC(num_nodes=3, quad_type="RADAU-RIGHT", QI="IE")

    u0 = u_exact(prob, 0.0)

    step = Step(prob, sweeper, 0.0, 1e-1, 1.0, 1e-12, 1, u0)

    @test step isa Step

    @test step.problem isa AbstractProblemODE
    @test step.problem isa LinearTestSPP

    @test step.sweeper isa AbstractSweeper
    @test step.sweeper isa FullyImplicitSDC

    @test step.t0 == 0.0
    @test step.dt == 1e-1
    @test step.Tend == 1.0

    @test step.state isa ConvergenceState

    @test step.state.restol == 1e-12
    @test step.state.maxiter == 1
end
