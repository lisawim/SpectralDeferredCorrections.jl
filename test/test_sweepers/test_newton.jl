using Test
using SpectralDeferredCorrections
using LinearAlgebra

@testset "Newton for linear system" begin
    A = I(2)
    u0 = [1.1, 1.9]
    b = [1.0, 2.0]

    g(u) = A * u - b
    dg(u) = A

    newton_tol = 1e-12
    newton_maxiter = 100
    
    # Note that Newton does need one iteration to solve the problem exact
    u = newton(g, dg, u0, newton_tol, newton_maxiter)
    @test u == [1.0, 2.0]
end

@testset "Newton for nonlinear function" begin
    u0 = 0.5

    g(u) = cos(u) - u^3
    dg(u) = -sin(u) - 3 * u^2

    newton_tol = 1e-12
    newton_maxiter = 300

    u = newton(g, dg, u0, newton_tol, newton_maxiter)
    u_ex = 0.86547403310161444662
    @test norm(u - u_ex) < 1e-14
end