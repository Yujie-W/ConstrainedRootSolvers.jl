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
    struct ResidualTolerance

# Fields
$(FIELDS)
"""
struct ResidualTolerance{FT} <: AbstractTolerance{FT}
    "Tolerance for residual"
    tol::Array{FT,1}
    "limit of iterations"
    n_limit::Int
end




"""
    struct SolutionTolerance

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
    struct StepTolerance

# Fields
$(FIELDS)
"""
struct StepTolerance{FT} <: AbstractTolerance{FT}
    "Tolerance for step length"
    tol::Array{FT,1}
end
