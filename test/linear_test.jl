using Test
using SpectralDeferredCorrections

@testset "LinearTestSPP" begin
    eps = 1e-1

    lin_problem = LinearTestEquation.initialize_problem(eps)

    @test typeof(lin_problem) == LinearTestEquation.LinearTestSPP

    t0 = 0.0
    u0 = lin_problem.u_exact(t0)

    @test u0 == [1.0, -2.0]
end