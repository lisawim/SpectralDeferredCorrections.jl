module AbstractNumericalMethod

using ..Errors

export AbstractSweeper, predict_step, update_step, compute_residual, compute_last_node


abstract type AbstractSweeper end


function predict_step(sweeper::AbstractSweeper)
    throw(NotImplementedError("Prediction routine needs to be implemented!"))
end

function update_step(sweeper::AbstractSweeper)
    throw(NotImplementedError("Solver does need a update_step function"))
end

function compute_residual(sweeper::AbstractSweeper)
    throw(NotImplementedError("Routine to compute residual has to be implemented!"))
end

function compute_last_node(sweeper::AbstractSweeper)
    throw(NotImplementedError("Routine to compute value on last node is missing!"))
end

end