using Test
using SpectralDeferredCorrections
import .AbstractProblem
import .LinearTestEquation

@testset "Testing SpectralDeferredCorrections" begin
    @test add_numbers(2, 3) == 5
    @test add_numbers(-1, 1) == 0
end

include("test_abstract_problem.jl")

@testset "Linear Test SPP" begin
    t0 = 0.0
    eps = 1e-1

    lin_problem = initialize_problem(LinearTestSPP, eps, t0)

    @test lin_problem isa LinearTestSPP

    u0 = u_exact(lin_problem, t0)

    lamb_diff = 2.0
    lamb_alg = -1.0
    A = [lamb_diff lamb_alg; lamb_diff / eps -lamb_alg / eps]

    problem = LinearTestSPP(A, eps, u0)

    @test problem isa LinearTestSPP

    @test u0 == [1.0, -2.0]

    rhs = f(lin_problem, t0, u0)

    @test rhs == lin_problem.A * u0

    @test rhs == f(problem, t0, u0)

    @test u_exact(problem, t0) == u0

    # Test that it raises an error for t ≠ 0.0
    @test_throws NotImplementedError u_exact(lin_problem, 1.0)
end

using Coverage

# Process raw coverage files in the "src" directory
results = Coverage.process_folder("src")

# Manually write LCOV format
open("lcov.info", "w") do io
    for file_result in results
        # Write LCOV file header
        println(io, "TN:")  # Test name (optional)
        println(io, "SF:$(file_result.filename)")  # Source file name

        # Iterate over coverage data
        for (line_number, execution_count) in enumerate(file_result.coverage)
            if !isnothing(execution_count)  # Only include lines with coverage info
                println(io, "DA:$(line_number),$(execution_count)")
            end
        end

        # End of file record
        println(io, "end_of_record")
    end
end

println("lcov.info generated successfully!")
