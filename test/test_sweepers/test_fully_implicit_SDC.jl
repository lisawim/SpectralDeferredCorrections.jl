using Test
using SpectralDeferredCorrections

@testset "FullyImplicitSDC - check initialization" begin
    prob = LinearTestSPP(0.1)

    sweeper = FullyImplicitSDC(num_nodes = 3, quad_type = "RADAU-RIGHT", QI = "IE")

    @test sweeper.collocation isa Collocation

    @test predict_values(prob, sweeper) == 0
    @test update_nodes(prob, sweeper) == 0
    @test compute_residual(prob, sweeper) == 0
    @test compute_last_node(prob, sweeper) == 0
end
