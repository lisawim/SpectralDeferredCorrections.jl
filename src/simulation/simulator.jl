module Simulation

using SpectralDeferredCorrections

using ..StepBase
using ..SimulationBase
using ..ProblemODEBase

import ..SimulationBase: run_simulation

export Simulator

struct Simulator <: AbstractSimulator
    step::Step

    function Simulator(problem, t0, dt, Tend, restol, maxiter)
        # Get initial condition at initial time
        u0 = u_exact(problem, t0)

        step = Step(problem, t0, dt, Tend, restol, maxiter, u0)

        return new(step)
    end
end

function run_simulation(simulator::Simulator)
    # Shortcuts
    sim = simulator
    S = simulator.step

    t = S.t0
    u = S.u0
    ts = [t]
    us = [u]

    while t < S.Tend
        # Handle the final step to avoid overshooting
        dt_actual = min(S.dt, S.Tend - t)

        iterate(sim)
        t += dt_actual

        push!(us, u)
        push!(ts, t)

        println("t=$t and u0=$(S.u0)")
    end

    return ts, us
end

function iterate(simulator::Simulator)
    S = simulator.step
    iter = 0

    while iter <= S.state.maxiter
        iter += 1
    end
end

end
