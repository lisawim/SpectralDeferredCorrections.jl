module SpectralDeferredCorrections

using LinearAlgebra


# Include core modules
include(joinpath(@__DIR__, "core/errors.jl"))
include(joinpath(@__DIR__, "core/abstract_problem.jl"))

# Include problem files
include(joinpath(@__DIR__, "problems/linear_test.jl"))

# Include solvers
include(joinpath(@__DIR__, "sweepers/inner_solvers.jl"))

using .AbstractProblem
using .Errors
using .LinearTestEquation
using .InnerSolvers

export AbstractDifferentialProblem
export LinearTestSPP, f, solve, u_exact
export NotImplementedError
export newton

end
