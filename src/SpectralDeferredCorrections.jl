module SpectralDeferredCorrections

using LinearAlgebra

# Include core modules
include(joinpath(@__DIR__, "core/errors.jl"))
include(joinpath(@__DIR__, "core/abstract_problem.jl"))
include(joinpath(@__DIR__, "core/abstract_simulator.jl"))
include(joinpath(@__DIR__, "core/abstract_sweeper.jl"))

# Include problem files
include(joinpath(@__DIR__, "problems/linear_test.jl"))

include(joinpath(@__DIR__, "simulation/simulator.jl"))

# Include solvers
include(joinpath(@__DIR__, "sweepers/inner_solvers.jl"))


using .AbstractProblem
using .AbstractSweeper
using .AbstractSimulator

using .Errors
using .LinearTestEquation
using .InnerSolvers
using .Simulation


export AbstractDifferentialProblem
export AbstractSweeper, predict_step, update_step, compute_residual, compute_last_node
export AbstractSimulator, run, iterate, check_convergence

export LinearTestSPP, f, solve, u_exact
export ConvergenceError, NotImplementedError
export newton

export Simulator

end
