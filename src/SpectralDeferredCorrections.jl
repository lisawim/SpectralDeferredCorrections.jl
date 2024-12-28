module SpectralDeferredCorrections

using LinearAlgebra
using PyCall
using StaticArrays

# Include core modules
include(joinpath(@__DIR__, "core/errors.jl"))
include(joinpath(@__DIR__, "core/collocation.jl"))
include(joinpath(@__DIR__, "core/simulation.jl"))
include(joinpath(@__DIR__, "core/problem_ode.jl"))
include(joinpath(@__DIR__, "core/sweeper.jl"))
include(joinpath(@__DIR__, "core/step.jl"))

# Include problem files
include(joinpath(@__DIR__, "problems/linear_test.jl"))

# Include solvers
include(joinpath(@__DIR__, "sweepers/fully_implicit_SDC.jl"))
include(joinpath(@__DIR__, "sweepers/inner_solvers.jl"))

include(joinpath(@__DIR__, "simulation/simulator.jl"))

using .ProblemODEBase
using .Errors
using .SweeperBase
using .CollocationBase
using .SimulationBase
using .LinearTestEquation
using .InnerSolvers
using .Simulation
using .StepBase

using .FullyImplicitSDCSweeper

export AbstractProblemODE
export LinearTestSPP, f, solve, u_exact

export ConvergenceError, NotImplementedError, ParameterError

export AbstractSweeper
export predict_values, update_nodes, compute_residual, compute_last_node

export Collocation, get_implicit_Qdelta, check_key_exists

export FullyImplicitSDC

export newton_scalar, newton_vector

export AbstractSimulator
export run_simulation
export Simulator

export Step, State, Parameters
export prepare_next_step, compute_next_step

end
