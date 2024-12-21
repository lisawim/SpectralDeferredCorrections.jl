module FullyImplicitSDC

using SpectralDeferredCorrections

using ..ProblemODEBase
using ..SweeperBase

export FullyImplicitSDCSweeper


struct FullyImplicitSDCSweeper <: SweeperBase.AbstractSweeper
    #sollocation::
end

function FullyImplicitSDCSweeper(num_nodes)

end

function SweeperBase.predict_step(problem::AbstractProblemODE, sweeper::FullyImplicitSDCSweeper)
    return 0
end

function SweeperBase.update_step(problem::AbstractProblemODE, sweeper::FullyImplicitSDCSweeper)
    return 0
end

function SweeperBase.compute_residual(problem::AbstractProblemODE, sweeper::FullyImplicitSDCSweeper)
    return 0
end

function SweeperBase.compute_last_node(problem::AbstractProblemODE, sweeper::FullyImplicitSDCSweeper)
    return 0
end

end