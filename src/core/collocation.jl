module CollocationBase

using PyCall
using Polynomials
using LinearAlgebra
using SpecialMatrices
using ..Errors

export Collocation, get_implicit_Qdelta, check_key_exists

struct Collocation
    num_nodes::Integer
    quad_type::String
    t_left::Float64
    t_right::Float64
    nodes::Vector{Float64}
    weights::Vector{Float64}
    Q::Matrix{Float64}
    QI::String

    # Inner constructor
    function Collocation(
            num_nodes::Integer,
            quad_type::String,
            t_left::Float64,
            t_right::Float64,
            nodes::Vector{Float64},
            weights::Vector{Float64},
            Q::Matrix{Float64},
            QI::String
    )
        return new(num_nodes, quad_type, t_left, t_right, nodes, weights, Q, QI)
    end

    # Outer constructor with keyword arguments
    function Collocation(; num_nodes::Union{Integer, Nothing} = nothing,
            quad_type::String = "RADAU-RIGHT",
            QI::Union{String, Nothing} = nothing,
            t_left::Float64 = 0.0, t_right::Float64 = 1.0)
        if isnothing(num_nodes)
            throw(ParameterError("Number of collocation nodes `num_nodes` must be provided!"))
        end

        if isnothing(QI)
            throw(ParameterError("Type of QDelta matrix `QI` must be provided!"))
        end

        nodes, weights, Q = compute_Qcoefficients(num_nodes, quad_type, t_left, t_right)

        return Collocation(
            num_nodes, quad_type, t_left, t_right, nodes, weights, Q, QI)
    end
end

function get_implicit_Qdelta(
        collocation::Collocation, QI::String, k::Union{Int, Nothing} = nothing)
    qmat = pyimport("qmat")
    QI_gen = qmat.QDELTA_GENERATORS[QI]
    gen = QI_gen(Q = collocation.Q, nNodes = collocation.num_nodes,
        nodeType = "LEGENDRE", quadType = collocation.quad_type,
        nodes = collocation.nodes, tLeft = collocation.t_left)

    if isnothing(k)
        return gen.genCoeffs()
    else
        return gen.genCoeffs(k = k)
    end
end

function compute_Qcoefficients(
        num_nodes::Int, quad_type::String, t_left::Float64, t_right::Float64)
    M = num_nodes
    x = Polynomial([t_left, t_right])

    if quad_type == "GAUSS"
        poly = x^M * (x - 1)^M
        poly_der = derivative(poly, M)
    elseif quad_type == "LOBATTO"
        poly = x^(M - 1) * (x - 1)^(M - 1)
        poly_der = derivative(poly, M - 2)
    elseif quad_type == "RADAU-LEFT"
        poly = x^M * (x - 1)^(M - 1)
        poly_der = derivative(poly, M - 1)
    elseif quad_type == "RADAU-RIGHT"
        poly = x^(M - 1) * (x - 1)^M
        poly_der = derivative(poly, M - 1)
    else
        throw(NotImplementedError("Qaudrature rule $quad_type is not implemented!"))
    end

    nodes = roots(poly_der)

    # See "Approximating Runge-Kutta matrices by triangular matrices", W. Hoffmann, J. J. B. De Swart, Sec. 2
    V = Vandermonde(nodes)
    C = Diagonal(nodes)
    R = Diagonal([1 / i for i in 1:M])
    Q = C * V * R * inv(V)

    weights = V' \ [1 / i for i in 1:M]

    return nodes, weights, Q
end

end
