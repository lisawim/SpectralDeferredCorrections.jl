module FullyImplicitSDCSweeper

using SpectralDeferredCorrections

using ..CollocationBase
using ..ProblemODEBase
using ..SweeperBase

import ..SweeperBase: predict_values, update_nodes, compute_residual, compute_last_node

export FullyImplicitSDC

struct FullyImplicitSDC <: AbstractSweeper
    collocation::Collocation
    QImat::Matrix{Float64}
end

function FullyImplicitSDC(
        num_nodes::Int, quad_type::String, QI::String, node_type::String = "LEGENDRE")
    collocation = Collocation(num_nodes, quad_type, node_type)

    QImat = get_implicit_Qdelta(collocation, QI)

    return FullyImplicitSDC(collocation, QImat)
end

function predict_values(problem::AbstractProblemODE, sweeper::FullyImplicitSDC)
    return 0
end

function update_nodes(problem::AbstractProblemODE, sweeper::FullyImplicitSDC)
    return 0
end

function compute_residual(problem::AbstractProblemODE, sweeper::FullyImplicitSDC)
    return 0
end

function compute_last_node(problem::AbstractProblemODE, sweeper::FullyImplicitSDC)
    return 0
end

end
