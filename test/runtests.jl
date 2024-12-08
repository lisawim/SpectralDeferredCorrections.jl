using Coverage
using SpectralDeferredCorrections
using Test

process_folder()  # Generates the lcov.info file

using Test
using SpectralDeferredCorrections  # Use the module

@testset "Testing SpectralDeferredCorrections" begin
    @test add_numbers(2, 3) == 5
    @test add_numbers(-1, 1) == 0
end
