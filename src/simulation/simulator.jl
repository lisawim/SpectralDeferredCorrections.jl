module Simulation

using SpectralDeferredCorrections

using ..SimulationBase
using ..ProblemODEBase

import ..SimulationBase: run_simulation

export Simulator

struct Simulator <: AbstractSimulator
    problem::AbstractProblemODE
    u0::AbstractVector
    t0::AbstractFloat
    dt::AbstractFloat
    Tend::AbstractFloat
    restol::AbstractFloat
    maxiter::Integer

    function Simulator(problem, t0, dt, Tend, restol, maxiter)
        # Get initial condition at initial time
        u0 = u_exact(problem, t0)

        return new(problem, u0, t0, dt, Tend, restol, maxiter)
    end
end

function run_simulation(simulator::Simulator)
    # Shortcuts
    sim = simulator

    t = sim.t0
    u = sim.u0
    ts = [t]
    us = [u]

    while t < sim.Tend
        # Handle the final step to avoid overshooting
        dt_actual = min(sim.dt, sim.Tend - t)

        iterate(sim)
        t += dt_actual

        println("t=$t and u0=$(sim.u0)")
    end
end

function iterate(simulator::Simulator)
    iter = 0

    while iter <= simulator.maxiter
        iter += 1
    end
end

end
