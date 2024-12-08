using Coverage
using SpectralDeferredCorrections
using Test

@testset "Testing SpectralDeferredCorrections" begin
    @test add_numbers(2, 3) == 5
    @test add_numbers(-1, 1) == 0
end

# Generate coverage report
Coverage.process_folder("src")
Coverage.lcov("src", "lcov.info")  # Creates lcov.info file
