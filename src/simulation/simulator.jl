module Simulation

using SpectralDeferredCorrections

using ..StepBase
using ..SimulationBase
using ..SweeperBase
using ..ProblemODEBase

import ..SimulationBase: run_simulation

export Simulator

struct Simulator{T} <: AbstractSimulator
    step::Step{T}
end

function Simulator(problem::AbstractProblemODE, sweeper::AbstractSweeper,
        t0::Float64, dt::Float64, Tend::Float64,
        restol::Float64, maxiter::Int)
    # Get initial condition at initial time
    u0 = u_exact(problem, t0)

    # Initialize a Step instance
    step = Step(problem, sweeper, t0, dt, Tend, restol, maxiter, u0)

    # Return a Simulator instance
    return Simulator{eltype(u0)}(step)
end

function run_simulation(simulator::Simulator{T}) where {T}
    # Shortcuts
    sim = simulator
    S = simulator.step

    t = S.t0
    u = S.u0
    ts = Float64[]
    us = Vector{Vector{T}}()

    # Initialize storage
    push!(ts, t)
    push!(us, u)

    while t < S.Tend
        # Handle the final step to avoid overshooting
        dt_actual = min(S.dt, S.Tend - t)

        iterate(sim)
        t += dt_actual

        push!(us, u)
        push!(ts, t)

        #println("t=$t and u0=$(S.u0)")
    end

    return ts, us
end

function iterate(simulator::Simulator{T}) where {T}
    S = simulator.step
    iter = 0

    while iter <= S.state.maxiter
        iter += 1
    end
end

end
