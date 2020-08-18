###############################################################################
#
# Judge if root is found
#
###############################################################################
"""
    if_break_uni(
                tol::AbstractTolerance{FT},
                x1::FT,
                x2::FT,
                y::FT
    ) where {FT<:AbstractFloat}

Determine whether to break, given
- `tol` [`ResidualTolerance`](@ref) or [`SolutionTolerance`](@ref) type
    tolerance struct
- `x1` Lower bound of x
- `x2` Upper bound of x
- `y` Residual of y
- `n` Current iteration
"""
function if_break_uni(
            tol::SolutionTolerance{FT},
            x1::FT,
            x2::FT,
            y::FT,
            n::Int
            ) where {FT<:AbstractFloat}
    return (abs(x1-x2) < tol.tol) || (n > tol.n_limit)
end




function if_break_uni(
            tol::ResidualTolerance{FT},
            x1::FT,
            x2::FT,
            y::FT,
            n::Int
            ) where {FT<:AbstractFloat}
    return (abs(y) < tol.tol) || (n > tol.n_limit)
end
