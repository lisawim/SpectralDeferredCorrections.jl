module CollocationBase

using PyCall
using Conda
using ..Errors

export Collocation, get_implicit_Qdelta, check_key_exists

struct Collocation
    num_nodes::Integer
    quad_type::String
    node_type::String
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
            node_type::String,
            t_left::Float64,
            t_right::Float64,
            nodes::Vector{Float64},
            weights::Vector{Float64},
            Q::Matrix{Float64},
            QI::String
    )
        return new(num_nodes, quad_type, node_type, t_left, t_right, nodes, weights, Q, QI)
    end

    # Outer constructor with keyword arguments
    function Collocation(; num_nodes::Union{Integer, Nothing} = nothing,
            quad_type::String = "RADAU-RIGHT", node_type::String = "LEGENDRE",
            QI::Union{String, Nothing} = nothing,
            t_left::Float64 = 0.0, t_right::Float64 = 1.0)
        if isnothing(num_nodes)
            throw(ParameterError("Number of collocation nodes `num_nodes` must be provided!"))
        end

        if isnothing(QI)
            throw(ParameterError("Type of QDelta matrix `QI` must be provided!"))
        end

        #qmat = pyimport("qmat")
        qmat = pyimport_conda("qmat", "qmat")

        check_key_exists(qmat.Q_GENERATORS, "Collocation")

        # Generator for collocation
        gen = qmat.Q_GENERATORS["Collocation"](nNodes = num_nodes, nodeType = node_type,
            quadType = quad_type, tLeft = t_left, tRight = t_right)

        nodes = gen.nodes
        weights = gen.weights
        Q = gen.Q

        return Collocation(
            num_nodes, quad_type, node_type, t_left, t_right, nodes, weights, Q, QI)
    end
end

function get_implicit_Qdelta(
        collocation::Collocation, QI::String, k::Union{Int, Nothing} = nothing)
    qmat = pyimport("qmat")
    QI_gen = qmat.QDELTA_GENERATORS[QI]
    gen = QI_gen(Q = collocation.Q, nNodes = collocation.num_nodes,
        nodeType = collocation.node_type, quadType = collocation.quad_type,
        nodes = collocation.nodes, tLeft = collocation.t_left)

    if isnothing(k)
        return gen.genCoeffs(QI)
    else
        return gen.genCoeffs(QI, k = k)
    end
end

function check_key_exists(dict, key)
    val = get(dict, key, nothing)
    if isnothing(val)
        throw(KeyError("The key `Collocation` does not exist in `qmat.Q_GENERATORS`."))
    end
end

end
