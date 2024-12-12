using Test
using SpectralDeferredCorrections

@testset "Linear Test SPP" begin
    eps = 1e-1

    lin_problem = LinearTestSPP(eps)

    @test lin_problem isa LinearTestSPP

    t0 = 0.0
    u0 = u_exact(lin_problem, t0)

    lamb_diff = 2.0
    lamb_alg = -1.0
    A = [lamb_diff lamb_alg; lamb_diff / eps -lamb_alg / eps]

    @test u0 == [1.0, -2.0]

    rhs = f(lin_problem, t0, u0)

    @test rhs == lin_problem.A * u0

    @test rhs == f(lin_problem, t0, u0)

    @test u_exact(lin_problem, t0) == u0

    # Test that it raises an error for t ≠ 0.0
    @test_throws NotImplementedError u_exact(lin_problem, 1.0)
end