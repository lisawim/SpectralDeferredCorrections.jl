using Test
using SpectralDeferredCorrections
using LinearAlgebra

@testset "Newton for linear system" begin
    A = [1.0 2.0; 3.0 4.0]
    b = [1.0, 2.0]

    g(u) = A * u - b
    dg(u) = A

    # Note that Newton does need one iteration to solve the problem exact
    u0 = [0.0, 0.4]
    u = newton_vector(g, dg, u0, 1e-12, 10)

    @test isapprox(u, A \ b)
end

@testset "Newton for nonlinear function" begin
    u0 = 0.1

    g(u) = cos(u) - u^3
    dg(u) = -sin(u) - 3 * u^2

    u = newton_scalar(g, dg, u0, 1e-12, 20) 

    u_ex = 0.86547403310161444662
    @test isapprox(u, u_ex)

    u0_new = 1e5
    @test_throws ConvergenceError newton_scalar(g, dg, u0_new, 1e-12, 20)
end
