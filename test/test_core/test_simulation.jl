using Test
using SpectralDeferredCorrections

@testset "AbstractSimulator Test" begin
    struct DummySimulator <: AbstractSimulator end

    dummy_sim = DummySimulator()

    @test_throws NotImplementedError run_simulation(dummy_sim)
end
