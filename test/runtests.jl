using Test
using SpectralDeferredCorrections

@testset "Testing SpectralDeferredCorrections" begin
    @test add_numbers(2, 3) == 5
    @test add_numbers(-1, 1) == 0
end

@testset "Linear Test SPP" begin
    t0 = 0.0
    eps = 1e-1

    lin_problem = initialize_problem(LinearTestSPP, eps, t0)

    @test lin_problem isa LinearTestSPP

    u0 = u_exact(lin_problem, t0)

    @test u0 == [1.0, -2.0]

    rhs = f(lin_problem, t0, u0)

    @test rhs == lin_problem.A * u0

    # Test that it raises an error for t ≠ 0.0
    @test_throws NotImplementedError u_exact(lin_problem, 1.0)
end
