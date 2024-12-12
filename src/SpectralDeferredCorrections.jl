module SpectralDeferredCorrections


# Include core modules
include(joinpath(@__DIR__, "core/errors.jl"))
include(joinpath(@__DIR__, "core/abstract_problem.jl"))

# Include problem files
include(joinpath(@__DIR__, "problems/linear_test.jl"))

using .AbstractProblem
using .Errors
using .LinearTestEquation

export AbstractDifferentialProblem
export LinearTestSPP, f, u_exact
export NotImplementedError

end
