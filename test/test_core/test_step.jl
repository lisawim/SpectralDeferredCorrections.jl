using Test
using SpectralDeferredCorrections

@testset "Step - check initialization" begin
    prob = LinearTestSPP(1.0)
    sweeper = FullyImplicitSDC(num_nodes = 3, quad_type = "RADAU-RIGHT", QI = "IE")

    u0 = u_exact(prob, 0.0)

    step = Step(prob, sweeper, 0.0, 1e-1, 1.0, 1e-12, 1, u0)

    @test step isa Step

    @test step.problem isa AbstractProblemODE
    @test step.problem isa LinearTestSPP

    @test step.sweeper isa AbstractSweeper
    @test step.sweeper isa FullyImplicitSDC

    @test step.Tend == 1.0

    @test step.params isa Parameters

    @test step.params.restol == 1e-12
    @test step.params.maxiter == 1

    @test step.state isa State

    @test step.state.time == 0.0
    @test step.state.dt == 1e-1
    @test step.state.iter == 0
    @test isnothing(step.state.residual)
    @test step.state.done == false
end

@testset "Step - check functions" begin
    prob = LinearTestSPP(1.0)
    sweeper = FullyImplicitSDC(num_nodes = 3, quad_type = "RADAU-RIGHT", QI = "IE")

    u0 = u_exact(prob, 0.0)

    Tend = 1.0
    step = Step(prob, sweeper, 0.0, 1e-1, Tend, 1e-12, 1, u0)

    # Manipulate residual and iter to check if function does the correct things
    step.state.iter += 1
    step.state.residual = 1e-12

    prepare_next_step(step)

    @test step.state.iter == 0
    @test isnothing(step.state.residual)

    # Manipulate fields time and done as well
    step.state.time = step.Tend

    compute_next_step(step)

    @test isapprox(step.state.time, step.Tend + step.state.dt)
    @test step.state.done == true
end
