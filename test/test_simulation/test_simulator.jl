using Test
using SpectralDeferredCorrections

function test_setup()
    eps = 1.0
    prob = LinearTestSPP(eps)

    t0 = 0.0
    dt = 1e-1
    Tend = 1.0

    restol = 1e-12
    maxiter = 1

    sim = Simulator(prob, t0, dt, Tend, restol, maxiter)

    return t0, dt, Tend, restol, maxiter, sim
end

@testset "Simulator - check initialization" begin
    t0, dt, Tend, restol, maxiter, sim = test_setup()

    @test sim.problem isa AbstractProblemODE
    @test sim.problem isa LinearTestSPP

    @test sim.t0 == t0
    @test sim.dt == dt
    @test sim.Tend == Tend

    @test sim.restol == restol
    @test sim.maxiter == maxiter
end

@testset "Simulator - check run_simulation" begin
    t0, dt, Tend, restol, maxiter, sim = test_setup()

    ts, us = run_simulation(sim)

    @test ts[end] == Tend
    @test us[end] == sim.u0
end