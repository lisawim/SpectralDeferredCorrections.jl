using Coverage

# Process raw coverage data from the "src" directory
results = Coverage.process_folder("src")

# Generate XML format
open("coverage.xml", "w") do io
    println(io, "<coverage>")
    for file_result in results
        println(io, "  <file path=\"$(file_result.filename)\">")
        for (line_number, execution_count) in enumerate(file_result.coverage)
            if !isnothing(execution_count)
                println(io, "    <line number=\"$(line_number)\" hits=\"$(execution_count)\"/>")
            end
        end
        println(io, "  </file>")
    end
    println(io, "</coverage>")
end

println("Generated coverage.xml successfully!")
