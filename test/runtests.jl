using Test
using SpectralDeferredCorrections

@testset "Testing SpectralDeferredCorrections" begin
    @test add_numbers(2, 3) == 5
    @test add_numbers(-1, 1) == 0
end

using Coverage

# Process raw coverage data
results = Coverage.process_folder("src")
