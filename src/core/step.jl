module StepBase

using ..ProblemODEBase
using ..SweeperBase

export Step, State, Parameters
export prepare_next_step, compute_next_step

"""
Stores the parameters to measure convergence. For an iterative solver the numerical solution
is comverged either the maximum number of iterations is exceeded or the residual tolerance
is reached.

### Fields

  - `restol`: Residual tolerance.
  - `maxiter`: Maximum number of iterations.
"""
struct Parameters
    restol::Float64
    maxiter::Integer

    function Parameters(restol::Float64, maxiter::Integer)
        return new(restol, maxiter)
    end
end

"""
Represent the current state in the simulation. It stores the current time of the step, the
time step size ``\\Delta t`` (which can be changed when adaptive time-stepping is implemented),
the current number of iteration, the current residual and a flag whether the solution is done.

### Fields

  - `time`: Time of the step.
  - `dt`: Time step size.
  - `iter`: Current number of iteration(s already done).
  - `residual`: Residual of the problem.
  - `done`: `false`, if simulation is not yet done.
"""
mutable struct State
    time::Float64
    dt::Float64
    iter::Int
    residual::Union{Float64, Nothing}
    done::Bool

    function State(t0::Float64, dt::Float64, Tend::Float64)
        iter = 0
        residual = nothing
        time = t0
        done = time > Tend
        return new(time, dt, iter, residual, done)
    end
end

"""
Represents a time step where every quantity is stored for.

### Fields

  - `problem`: Problem type.
  - `sweeper`: Sweeper type to solve problem.
  - `state`: Parameters for the simulation, i.e., current number of iterations etc.
  - `params`: Defines fixed parameters for measuring convergence, i.e., residual tolerance
    and maximum number of iterations.
  - `Tend`: End time of simulation.
  - `u0`: Initial condition (problem-specific).
"""
mutable struct Step{T}
    problem::AbstractProblemODE
    sweeper::AbstractSweeper
    params::Parameters
    state::State
    Tend::Float64
    u0::Vector{T}

    function Step(problem::AbstractProblemODE, sweeper::AbstractSweeper,
            t0::Float64, dt::Float64, Tend::Float64,
            restol::Float64, maxiter::Integer, u0::Vector{T}) where {T}
        params = Parameters(restol, maxiter)
        state = State(t0, dt, Tend)
        return new{T}(problem, sweeper, params, state, Tend, u0)
    end
end

"""
Prepares next time step by setting number of iterations back to zero and residual back to
`nothing`.
"""
function prepare_next_step(step::Step)
    step.state.iter = 0
    step.state.residual = nothing
end

"""
Time of next step is computed, i.e., the simulator moves forward to next step by computing
the new step time and decide whether the simulation is done or not.
"""
function compute_next_step(step::Step)
    step.state.time += step.state.dt
    step.state.done = step.state.time > step.Tend
end

end
