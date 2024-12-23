module SpectralDeferredCorrections

using LinearAlgebra
using StaticArrays

# Include core modules
include(joinpath(@__DIR__, "core/errors.jl"))
include(joinpath(@__DIR__, "core/simulation.jl"))
include(joinpath(@__DIR__, "core/problem_ode.jl"))
include(joinpath(@__DIR__, "core/step.jl"))

# Include problem files
include(joinpath(@__DIR__, "problems/linear_test.jl"))

# Include solvers
include(joinpath(@__DIR__, "sweepers/inner_solvers.jl"))

include(joinpath(@__DIR__, "simulation/simulator.jl"))

using .ProblemODEBase
using .Errors
using .SimulationBase
using .LinearTestEquation
using .InnerSolvers
using .Simulation
using .StepBase

export AbstractProblemODE
export LinearTestSPP, f, solve, u_exact
export ConvergenceError, NotImplementedError
export newton_scalar, newton_vector

export AbstractSimulator
export run_simulation
export Simulator

export Step, ConvergenceState

end
