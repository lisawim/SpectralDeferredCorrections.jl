module FullyImplicitSDCSweeper

using SpectralDeferredCorrections

using ..CollocationBase
using ..ProblemODEBase
using ..SweeperBase

import ..CollocationBase: get_implicit_Qdelta
import ..SweeperBase: predict_values, update_nodes, compute_residual, compute_last_node

export FullyImplicitSDC

struct FullyImplicitSDC <: AbstractSweeper
    collocation::Collocation
    QImat::Matrix{Float64}

    # Inner constructor
    function FullyImplicitSDC(collocation::Collocation, QImat::Matrix{Float64})
        new(collocation, QImat)
    end

    # Outer constructor with keyword arguments
    function FullyImplicitSDC(;
            num_nodes::Int, quad_type::String, QI::String, node_type::String = "LEGENDRE")
        # Initialize Collocation and QImat
        collocation = Collocation(
            num_nodes = num_nodes, quad_type = quad_type, node_type = node_type, QI = QI)
        QImat = get_implicit_Qdelta(collocation, QI)

        return FullyImplicitSDC(collocation, QImat)
    end
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
