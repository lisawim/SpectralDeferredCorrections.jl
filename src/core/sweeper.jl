module SweeperBase

using SpectralDeferredCorrections

using ..ProblemODEBase

export AbstractSweeper
export predict_values, update_nodes, compute_residual, compute_last_node

abstract type AbstractSweeper end

function predict_values(problem::AbstractProblemODE, sweeper::AbstractSweeper)
    throw(NotImplementedError("Prediction routine needs to be implemented!"))
end

function update_nodes(problem::AbstractProblemODE, sweeper::AbstractSweeper)
    throw(NotImplementedError("Solver does need a update_step function"))
end

function compute_residual(problem::AbstractProblemODE, sweeper::AbstractSweeper)
    throw(NotImplementedError("Routine to compute residual has to be implemented!"))
end

function compute_last_node(problem::AbstractProblemODE, sweeper::AbstractSweeper)
    throw(NotImplementedError("Routine to compute value on last node is missing!"))
end

end
