using Test
using SpectralDeferredCorrections
using LinearAlgebra

@testset "Newton for linear system" begin
    A = [1.0 2.0; 3.0 4.0]
    u0 = [0.0, 0.4]
    b = [1.0, 2.0]

    g(u) = A * u - b
    dg(u) = A

    # Since we have a linear problem Newton does need only one iteration to converge
    newton_tol = 1e-12
    newton_maxiter = 10
    println("Linear solve")
    u_ex = inv(A)*b
    println(u_ex)
    # Note that Newton does need one iteration to solve the problem exact
    u = newton(g, dg, u0, newton_tol, newton_maxiter)

    @test norm(u - u_ex) < 1e-14
end

@testset "Newton for nonlinear function" begin
    u0 = 0.1

    g(u) = cos(u) - u^3
    dg(u) = -sin(u) - 3 * u^2

    newton_tol = 1e-12
    newton_maxiter = 20

    u = newton(g, dg, u0, newton_tol, newton_maxiter)
    u_ex = 0.86547403310161444662
    @test norm(u - u_ex) < 1e-14

    u0_new = 1e5
    @test_throws ConvergenceError newton(g, dg, u0_new, newton_tol, newton_maxiter)
end