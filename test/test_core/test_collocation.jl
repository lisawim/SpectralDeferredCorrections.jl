using Test
using SpectralDeferredCorrections
using PyCall

@testset "Collocation - check initialization" begin
    coll = Collocation(num_nodes = 3, quad_type = "RADAU-RIGHT", QI = "IE")

    @test coll isa Collocation

    @test coll.num_nodes == 3
    @test coll.QI == "IE"
end

@testset "Collocation - check exception" begin
    # Check whether ParameterError is thrown if num_nodes is nothing
    @test_throws ParameterError Collocation(quad_type = "RADAU-RIGHT", QI = "IE")

    # Check whether ParameterError is thrown if QI is nothing
    @test_throws ParameterError Collocation(num_nodes = 3, quad_type = "RADAU-RIGHT")
end

@testset "Check if key does exists when import qmat" begin
    qmat = pyimport("qmat")

    check_key_exists(qmat.Q_GENERATORS, "Collocation")

    @test_throws KeyError check_key_exists(qmat.Q_GENERATORS, "RandomKey")
end
