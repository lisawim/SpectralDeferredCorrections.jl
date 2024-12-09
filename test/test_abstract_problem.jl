using Test
using SpectralDeferredCorrections

println(methods(initialize_problem))

@testset "AbstractProblem Tests" begin
    # Test that calling u_exact on an abstract type raises NotImplementedError
    struct DummyProblem <: AbstractDifferentialProblem end

    # Test that calling `f` raises `NotImplementedError`
    @test_throws NotImplementedError initialize_problem(DummyProblem, 0.0)

    dummy_problem = DummyProblem()

    @test_throws NotImplementedError f(dummy_problem, 0.0, [1.0, 2.0])

    @test_throws NotImplementedError u_exact(dummy_problem, 0.0)
end

@testset "AbstractProblem Interface Compatibility" begin
    struct DummyProblem2 <: AbstractDifferentialProblem
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

    function initialize_problem(::Type{<:DummyProblem2}, A, b, y0, t; kwargs...)
        return DummyProblem2(A, b, y0)
    end

    t0 = 0.0
    y0 = [1.0, 2.0]

    A = [1.0 0.0; 0.0 1.0]
    b = [1.0, 1.0]

    # Create a mock problem instance
    dummy_problem2 = DummyProblem2(A, b, y0)

    # Test u_exact at t = 0.0
    @test u_exact(dummy_problem2, t0) == y0

    @test f(dummy_problem2, t0, y0) == A * y0 + b

    @test initialize_problem(DummyProblem2, A, b, y0, t0) isa DummyProblem2
    @test initialize_problem(DummyProblem2, A, b, y0, t0) isa AbstractDifferentialProblem

    # Test that u_exact raises an error for t ≠ 0.0
    @test_throws NotImplementedError u_exact(dummy_problem2, 1.0)
end
