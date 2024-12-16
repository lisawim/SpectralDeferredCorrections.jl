module FullyImplicitSDC

using SpectralDeferredCorrections

using ..AbstractNumericalMethod

export FullyImplicitSDCSweeper


struct FullyImplicitSDCSweeper <: AbstractNumericalMethod.AbstractSweeper
    
end

function AbstractNumericalMethod.predict_step(sweeper::FullyImplicitSDCSweeper)
    return 0
end

function AbstractNumericalMethod.update_step(sweeper::FullyImplicitSDCSweeper)
    return 0
end

function AbstractNumericalMethod.compute_residual(sweeper::FullyImplicitSDCSweeper)
    return 0
end

function AbstractNumericalMethod.compute_last_node(sweeper::FullyImplicitSDCSweeper)
    return 0
end

end