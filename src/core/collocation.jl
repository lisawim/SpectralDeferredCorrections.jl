module CollocationBase

using PyCall
qmat = pyimport("qmat")
using ..Errors

export Collocation

struct Collocation
    num_nodes::Integer
    node_type::String
    quad_type::String
    t_left::Float64
    t_right::Float64
    nodes::Vector{Float64}
    weights::Vector{Float64}
    Q::Matrix{Float64}
    QD::String
end

function Collocation(num_nodes::Integer = nothing, quad_type::String = "RADAU-RIGHT",
        node_type::String = "LEGENDRE", QD::String = nothing, t_left::Float64 = 0.0, t_right::Float64 = 1.0)
    if isnothing(num_nodes)
        throw(Parameter("Number of collocation nodes num_nodes have to be passed!"))
    end

    if isnothing(QD)
        throw(ParameterError("Type of QDelta matrix must be provided!"))
    end

    # Generator for collocation
    gen = qmat.Q_GENERATORS["Collocation"](
        nNodes = num_nodes, nodeType = node_type, quadType = quad_type, tLeft = t_left, tRight = t_right
    )

    nodes = gen.nodes
    weights = gen.weights
    Q = gen.Q
    return Collocation(
        num_nodes, node_type, quad_type, t_left, t_right, nodes, weights, Q, QD)
end

function get_implicit_Qdelta(collocation::Collocation, QI::String, k::Int = nothing)
    QD_gen = qmat.QDELTA_GENERATORS[collocation.QD]
    gen = QD_gen(Q = collocation.gen.Q, nNodes = collocation.num_nodes,
        nodeType = collocation.node_type, quadType = collocation.quad_type,
        nodes = collocation.nodes, tLeft = collocation.tleft
    )

    if isnothing(k)
        return gen.genCoeff(QI)
    else
        return gen.genCoeff(QI, k = k)
    end
end

end
