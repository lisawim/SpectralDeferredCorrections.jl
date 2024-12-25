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

@testset "Collocation - check existing key" begin
    qmat = pyimport("qmat")

    check_key_exists(qmat.Q_GENERATORS, "Collocation")

    @test_throws KeyError check_key_exists(qmat.Q_GENERATORS, "RandomKey")
end

@testset "Collocation - check return of implicit Qdelta" begin
    coll = Collocation(num_nodes = 3, quad_type = "RADAU-RIGHT", QI = "IE")

    QI = get_implicit_Qdelta(coll, "IE")

    @test QI isa AbstractMatrix

    @test size(QI) == (3, 3)

    QI_MIN = get_implicit_Qdelta(coll, "MIN-SR-FLEX", k = 1)

    @test QI_MIN isa AbstractMatrix

    @test size(QI_MIN) == (3, 3)
end
