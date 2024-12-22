using Test
using SpectralDeferredCorrections
using LinearAlgebra

@testset "Linear Test SPP - check initialization" begin
    prob = LinearTestSPP(1.0)

    @test prob isa LinearTestSPP

    @test isapprox(prob.A, [2.0 -1.0; 2.0 1.0])

    @test u_exact(prob, 0.0) == [1.0, -2.0]

    rhs = f(prob, 0.0, [1.0, -2.0])

    @test rhs == prob.A * [1.0, -2.0]

    @test rhs == f(prob, 0.0, [1.0, -2.0])

    @test u_exact(prob, 0.0) == [1.0, -2.0]

    # Test that it raises an error for t ≠ 0.0
    @test_throws NotImplementedError u_exact(prob, 1.0)
end

@testset "LinearTestSPP - check solve" begin
    prob = LinearTestSPP(1.0)

    u0 = u_exact(prob, 0.0)
    factor = 1.0
    rhs = copy(u0)

    u = solve(prob, rhs, 0.0, u0, 1.0)

    @test u == (I - 1.0 * prob.A) \ rhs
end
