module SpectralDeferredCorrections

using LinearAlgebra
using PyCall

# Include core modules
include(joinpath(@__DIR__, "core/errors.jl"))
include(joinpath(@__DIR__, "core/collocation.jl"))
include(joinpath(@__DIR__, "core/problem_ode.jl"))
include(joinpath(@__DIR__, "core/simulation.jl"))
include(joinpath(@__DIR__, "core/sweeper.jl"))
include(joinpath(@__DIR__, "core/step.jl"))

# Include problem files
include(joinpath(@__DIR__, "problems/linear_test.jl"))

include(joinpath(@__DIR__, "simulation/simulator.jl"))

# Include solvers
include(joinpath(@__DIR__, "sweepers/fully_implicit_SDC.jl"))
include(joinpath(@__DIR__, "sweepers/inner_solvers.jl"))

using .CollocationBase
using .ProblemODEBase
using .SweeperBase
using .SimulationBase
using .StepInitialization

using .Errors
using .LinearTestEquation
using .InnerSolvers
using .Simulation
using .FullyImplicitSDC

export ConvergenceState
export Step

export Collocation

export AbstractProblemODE, f, solve, u_exact
export AbstractSweeper, predict_step, update_step, compute_residual, compute_last_node
export AbstractSimulator, run_simulation

export LinearTestSPP
export ConvergenceError, NotImplementedError, ParameterError
export newton

export FullyImplicitSDCSweeper

export Simulator

end
