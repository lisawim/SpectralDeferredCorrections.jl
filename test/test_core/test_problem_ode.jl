using Test
using SpectralDeferredCorrections

@testset "AbstractProblem Tests" begin
    # Test that calling u_exact on an abstract type raises NotImplementedError
    struct DummyProblem <: AbstractProblemODE end

    dummy_problem = DummyProblem()

    @test_throws NotImplementedError f(dummy_problem, 0.0, [1.0, 2.0])

    @test_throws NotImplementedError solve(dummy_problem, [2.0, 1.0], 0.0, [0.0, 0.0], 0.1)

    @test_throws NotImplementedError u_exact(dummy_problem, 0.0)
end

@testset "AbstractProblem Interface Compatibility" begin
    struct DummyProblem2 <: AbstractProblemODE
        A::Matrix{Float64}
        b::Vector{Float64}
        y0::Vector{Float64}
    end

    # Extend u_exact for the dummy problem
    function u_exact(problem::DummyProblem2, t)
        if t == 0.0
            return problem.y0
        else
            throw(NotImplementedError("u_exact is only implemented for t = 0.0"))
        end
    end

    function f(problem::DummyProblem2, t, u)
        return problem.A * u + problem.b
    end

    # Create a mock problem instance
    prob = DummyProblem2([1.0 0.0; 0.0 1.0], [1.0, 1.0], [1.0, 2.0])

    # Test u_exact at t = 0.0
    @test u_exact(prob, 0.0) == [1.0, 2.0]

    @test f(prob, 0.0, [1.0, 2.0]) == prob.A * prob.y0 + prob.b

    @test prob isa DummyProblem2
    @test prob isa AbstractProblemODE

    # Test that u_exact raises an error for t ≠ 0.0
    @test_throws NotImplementedError u_exact(prob, 1.0)
end
