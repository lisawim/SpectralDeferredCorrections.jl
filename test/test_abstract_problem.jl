using Test
using SpectralDeferredCorrections

@testset "AbstractProblem Tests" begin
    # Test that calling u_exact on an abstract type raises NotImplementedError
    struct DummyProblem <: AbstractDifferentialProblem end

    dummy_problem = DummyProblem()

    # Test that calling u_exact raises NotImplementedError
    @test_throws NotImplementedError u_exact(dummy_problem, 0.0)
end

@testset "AbstractProblem Interface Compatibility" begin
    struct DummyProblem2 <: AbstractDifferentialProblem
        y0::Vector{Float64}
    end

    # Extend u_exact for the mock problem
    function u_exact(problem::DummyProblem2, t)
        if t == 0.0
            return problem.y0
        else
            throw(NotImplementedError("u_exact is only implemented for t = 0.0"))
        end
    end

    # Create a mock problem instance
    dummy_problem2 = DummyProblem2([1.0, 2.0])

    # Test u_exact at t = 0.0
    @test u_exact(dummy_problem2, 0.0) == [1.0, 2.0]

    # Test that u_exact raises an error for t ≠ 0.0
    @test_throws NotImplementedError u_exact(dummy_problem2, 1.0)
end
