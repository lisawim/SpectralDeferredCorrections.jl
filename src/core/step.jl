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

struct Step
    problem::AbstractProblemODE
    state::ConvergenceState
    t0::Float64
    dt::Float64
    Tend::Float64
    u0::AbstractVector

    function Step(problem::AbstractProblemODE, t0::Float64, dt::Float64, Tend::Float64,
            restol::Float64, maxiter::Integer, u0::AbstractVector)
        state = ConvergenceState(restol, maxiter)
        return new(problem, state, t0, dt, Tend, u0)
    end
end

end
