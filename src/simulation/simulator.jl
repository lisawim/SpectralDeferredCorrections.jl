module Simulation

using SpectralDeferredCorrections


struct Simulator <: AbstractSimulator
    problem::AbstractDifferentialProblem
    sweeper::AbstractNumericalMethod
    t0::AbstractFloat
    dt::AbstractFloat
    Tend::AbstractFloat
    restol::AbstractFloat
    maxiter::Integer
end

function AbstractSimulator.run(simulator::Simulator)
    t0, dt, Tend = simulator.t0, simulator.dt, simulator.Tend

    t = t0
    u = prob.u0
    ts = [t]
    us = [u]

    while t < Tend
        # Handle the final step to avoid overshooting
        dt_actual = min(dt, Tend - t)

        iterate(simulator)

        
    end

end

function AbstractSimulator.iterate(simulator::Simulator)
    iter = 0

    while !converged
        global converged = check_convergence(simulator, iter)

        predict_step(simulator.problem)

        update_step(simulator.problem)

        iter += 1
        global converged = check_convergence(simulator, iter)
    end

    compute_last_node(simulator.problem)

end

function AbstractSimulator.check_convergence(simulator::Simulator, iter::Integer)
    restol = simulator.restol
    maxiter = simulator.maxiter

    residual = compute_residual(simulator.problem)

    converged = residual <= restol || iter >= maxiter

    return converged
end

end