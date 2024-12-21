module SpectralDeferredCorrections

using LinearAlgebra

# Include core modules
include(joinpath(@__DIR__, "core/errors.jl"))
include(joinpath(@__DIR__, "core/simulation.jl"))
include(joinpath(@__DIR__, "core/problem_ode.jl"))

# Include problem files
include(joinpath(@__DIR__, "problems/linear_test.jl"))

# Include solvers
include(joinpath(@__DIR__, "sweepers/inner_solvers.jl"))

using .ProblemODEBase
using .Errors
using .SimulationBase
using .LinearTestEquation
using .InnerSolvers

export AbstractProblemODE
export LinearTestSPP, f, solve, u_exact
export ConvergenceError, NotImplementedError
export newton

export AbstractSimulator, run_simulation

end
