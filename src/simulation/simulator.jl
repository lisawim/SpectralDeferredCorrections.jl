module Simulation

using SpectralDeferredCorrections

using ..StepInitialization
using ..SimulationBase
using ..ProblemODEBase
using ..SweeperBase


export Simulator


struct Simulator <: SimulationBase.AbstractSimulator
    step::Step
    #problem::AbstractProblemODE
    #sweeper::AbstractSweeper
    #t0::AbstractFloat
    #dt::AbstractFloat
    #Tend::AbstractFloat
    #restol::AbstractFloat
    #maxiter::Integer

    function Simulator(problem, sweeper, t0, dt, Tend, restol, maxiter)
        # Get initial condition at initial time
        u0 = u_exact(problem, t0)

        # Initialize step with problem, sweeper and parameters to monitor convergence
        step = Step(problem, sweeper, t0, dt, Tend, restol, maxiter, u0)
    
        return new(step)
    end
end

function SimulationBase.run_simulation(simulator::Simulator)
    # Shortcuts
    sim = simulator
    S = sim.step

    t = S.t0
    u = S.u0
    ts = [t]
    us = [u]

    while t < S.Tend
        # Handle the final step to avoid overshooting
        dt_actual = min(S.dt, S.Tend - t)

        iter = 0
        converged = check_convergence(sim, iter)

        if !converged
            iterate(sim)
        else
            t += dt_actual
        end

        println("t=$t and u0=$(S.u0)")
   
    end

end

function iterate(simulator::Simulator)
    iter = 0
    converged = false

    while !converged
        predict_step(simulator.problem, simulator.sweeper)

        update_step(simulator.problem, simulator.sweeper)
        println(iter)

        converged = check_convergence(simulator, iter)

        iter += 1
    end

    compute_last_node(simulator.problem, simulator.sweeper)

end

function check_convergence(simulator::Simulator, iter::Integer)
    S = simulator.step

    residual = compute_residual(S.problem, S.sweeper)

    converged = residual <= S.state.restol || iter >= S.state.maxiter

    return converged
end

function update_residual!(sweeper::AbstractSweeper, new_residual::Float64)
    sweeper.state = SweeperState(new_residual, sweeper.state.iter)
end

function increment_iter!(sweeper::AbstractSweeper)
    sweeper.state = SweeperState(sweeper.state.residual, sweeper.state.iter + 1)
end

end