module StepBase

using ..ProblemODEBase
using ..SweeperBase

export Step, ConvergenceState
export prepare_next_step, compute_next_step

struct ConvergenceState
    restol::Float64
    maxiter::Integer

    function ConvergenceState(restol::Float64, maxiter::Integer)
        return new(restol, maxiter)
    end
end

mutable struct Step{T}
    problem::AbstractProblemODE
    sweeper::AbstractSweeper
    state::ConvergenceState
    time::Float64
    dt::Float64
    Tend::Float64
    u0::Vector{T}
    iter::Int
    residual::Union{Float64, Nothing}
    done::Bool

    function Step(problem::AbstractProblemODE, sweeper::AbstractSweeper,
            t0::Float64, dt::Float64, Tend::Float64,
            restol::Float64, maxiter::Integer, u0::Vector{T}) where {T}
        state = ConvergenceState(restol, maxiter)
        time = t0
        iter = 0
        residual = nothing
        done = time > Tend
        return new{T}(problem, sweeper, state, time, dt, Tend, u0, iter, residual, done)
    end
end

function prepare_next_step(step::Step)
    step.iter = 0
    step.residual = nothing
end

function compute_next_step(step::Step)
    step.time += step.dt
    step.done = step.time > step.Tend
end

end
