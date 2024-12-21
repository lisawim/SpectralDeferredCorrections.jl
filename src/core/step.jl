module StepBase

using ..ProblemODEBase

export Step, ConvergenceState

struct ConvergenceState
    restol::Float64
    maxiter::Integer

    function ConvergenceState(restol::Float64, maxiter::Integer)
        return new(restol, maxiter)
    end
end

struct Step{T}
    problem::AbstractProblemODE
    state::ConvergenceState
    t0::Float64
    dt::Float64
    Tend::Float64
    u0::Vector{T}

    function Step(problem::AbstractProblemODE, t0::Float64, dt::Float64, Tend::Float64,
            restol::Float64, maxiter::Integer, u0::Vector{T}) where {T}
        state = ConvergenceState(restol, maxiter)
        return new{T}(problem, state, t0, dt, Tend, u0)
    end
end

end
