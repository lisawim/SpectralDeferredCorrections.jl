module InnerSolvers

export newton


function newton(g::Function, dg::Function, u0, newton_tol, maxiter)
    u = u0

    res = 99
    n = 0
    while n < maxiter
        res = norm(g(u), Inf)

        # Check if tolerance is already satisfied
        if res < newton_tol
            break
        end

        # Compute Newton direction
        Δu = -dg(u) \ g(u)

        # Newton update
        u += Δu

        # Increment iteration counter
        n += 1
    end

    return u
end

end