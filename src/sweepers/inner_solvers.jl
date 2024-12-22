module InnerSolvers

using LinearAlgebra
using StaticArrays
using SpectralDeferredCorrections
using ..Errors

export newton_scalar, newton_vector

function newton_scalar(
        g::Function, dg::Function, u0::Float64, newton_tol::Float64, newton_maxiter::Int)
    u = u0
    n = 0

    while n < newton_maxiter
        residual = g(u)
        res_norm = abs(residual)

        # Check if tolerance is satisfied
        if res_norm < newton_tol
            break
        end

        # Compute Newton step
        Δu = -g(u) / dg(u)

        # Update u
        u += Δu

        n += 1
    end

    residual = g(u)
    res_norm = abs(residual)
    if res_norm < newton_tol
        return u
    end

    throw(ConvergenceError("Newton did not converge after $n iterations!"))

    return u
end

function newton_vector(g::Function, dg::Function, u0::Vector{T},
        newton_tol::Float64, newton_maxiter::Int) where {T}
    u = MArray{Tuple{length(u0)}, T}(u0)  # Use MArray for mutability  # Convert to a static array
    Δu = copy(u0)  # Preallocate Δu
    residual = copy(u0)
    n = 0

    while n < newton_maxiter
        residual .= g(u)
        res_norm = norm(residual, Inf)

        # Check if tolerance is satisfied
        if res_norm < newton_tol
            return u
        end

        # Compute Newton step
        Δu .= -dg(u) \ residual

        # Update u
        u .= u .+ Δu

        n += 1
    end

    residual .= g(u)
    res_norm = norm(residual, Inf)
    if res_norm < newton_tol
        return u
    end

    throw(ConvergenceError("Newton did not converge after $n iterations!"))
end

end
