using Test
using SpectralDeferredCorrections

@testset "Testing SpectralDeferredCorrections" begin
    @test add_numbers(2, 3) == 5
    @test add_numbers(-1, 1) == 0
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
