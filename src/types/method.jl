###############################################################################
#
# Root finding method
#
###############################################################################
"""
Hierachy of AbstractRootSolvingMethod:
- BisectionMethod
- NelderMeadmethod
- NewtonBisectionMethod
- NewtonRaphsonMethod
- ReduceStepMethod
"""
abstract type AbstractRootSolvingMethod{FT} end




"""
    struct BisectionMethod

# Fields
$(FIELDS)
"""
struct BisectionMethod{FT} <: AbstractRootSolvingMethod{FT}
    "lower bound"
    x_min::FT
    "upper bound"
    x_max::FT
end




"""
    struct NelderMeadmethod

# Fields
$(FIELDS)
"""
struct NelderMeadmethod{FT} <: AbstractRootSolvingMethod{FT}
    "Simplex matrix of (N+1) * (N+1)"
    simplex::Array{Tuple,1}
end




"""
    struct NewtonBisectionMethod

# Fields
$(FIELDS)
"""
struct NewtonBisectionMethod{FT} <: AbstractRootSolvingMethod{FT}
    "Lower bound"
    x_min::FT
    "Upper bound"
    x_max::FT
    "Initial guess"
    x_ini::FT
end




"""
    struct NewtonRaphsonMethod

# Fields
$(FIELDS)
"""
struct NewtonRaphsonMethod{FT} <: AbstractRootSolvingMethod{FT}
    "Initial guess"
    x_ini::FT
end




"""
    struct ReduceStepMethod

# Fields
$(FIELDS)
"""
struct ReduceStepMethod{FT} <: AbstractRootSolvingMethod{FT}
    "Lower bound"
    x_mins::Array{FT,1}
    "Upper bound"
    x_maxs::Array{FT,1}
    "Initial guess"
    x_inis::Array{FT,1}
    "Initial step"
    Δ_inis::Array{FT,1}
end
