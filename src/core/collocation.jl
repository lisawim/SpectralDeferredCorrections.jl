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
end

function Collocation(num_nodes::Integer = nothing, node_type::String = "LEGENDRE",
        quad_type::String = "RADAU-RIGHT", t_left::Float64 = 0.0, t_right::Float64 = 1.0)
    if isnothing(num_nodes)
        throw(Parameter("Number of collocation nodes num_nodes have to be passed!"))
    end

    # Generator for collocation
    gen = qmat.Q_GENERATORS["Collocation"](
        nNodes = num_nodes, nodeType = node_type, quadType = quad_type, tLeft = t_left, tRight = t_right
    )

    nodes = gen.nodes
    weights = gen.weights
    Q = gen.Q
    return Collocation(num_nodes, node_type, quad_type, t_left, t_right, nodes, weights, Q)
end

end
