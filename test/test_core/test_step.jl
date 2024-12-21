using Test
using SpectralDeferredCorrections

@testset "Step - check initialization" begin
    eps = 1.0
    prob = LinearTestSPP(eps)

    t0 = 0.0
    dt = 1e-1
    Tend = 1.0

    restol = 1e-12
    maxiter = 1

    u0 = u_exact(prob, t0)

    step = Step(prob, t0, dt, Tend, restol, maxiter, u0)

    @test step isa Step

    @test step.problem isa AbstractProblemODE
    @test step.problem isa LinearTestSPP

    @test step.t0 == t0
    @test step.dt == dt
    @test step.Tend == Tend

    @test step.state isa ConvergenceState

    @test step.state.restol == restol
    @test step.state.maxiter == maxiter
end
