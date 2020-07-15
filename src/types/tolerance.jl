###############################################################################
#
# Tolerance for root solution
#
###############################################################################
"""
Hierachy of AbstractTolerance:
- ResidualTolerance
- SolutionTolerance
- StepTolerance
"""
abstract type AbstractTolerance{FT} end




"""
    struct ResidualTolerance{FT}

# Fields
$(FIELDS)
"""
struct ResidualTolerance{FT} <: AbstractTolerance{FT}
    "Tolerance for residual"
    tol::FT
    "limit of iterations"
    n_limit::Int
end




"""
    struct SolutionTolerance{FT}

# Fields
$(FIELDS)
"""
struct SolutionTolerance{FT} <: AbstractTolerance{FT}
    "Tolerance for solution"
    tol::FT
    "limit of iterations"
    n_limit::Int
end




"""
    struct SolutionToleranceND{FT}

# Fields
$(FIELDS)
"""
struct SolutionToleranceND{FT} <: AbstractTolerance{FT}
    "Tolerance for solution"
    tol::Array{FT,1}
    "limit of iterations"
    n_limit::Int
end
