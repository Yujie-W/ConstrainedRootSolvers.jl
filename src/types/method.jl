###############################################################################
#
# Root finding method
#
###############################################################################
"""
Hierachy of AbstractRootSolvingMethod:
- BisectionMethod
- NelderMeadMethod
- NewtonBisectionMethod
- NewtonRaphsonMethod
- ReduceStepMethod
- ReduceStepMethodND
"""
abstract type AbstractRootSolvingMethod{FT} end




"""
    struct BisectionMethod{FT}

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
    struct NelderMeadMethod{FT}

# Fields
$(FIELDS)
"""
Base.@kwdef mutable struct NelderMeadMethod{FT} <: AbstractRootSolvingMethod{FT}
    "Number of parameters to optimize"
    N::Int = 2
    "Initial values"
    x_inis::Array{FT,1} = zeros(FT,N+1)
    "Simplex array of array with dimension (N+1) * (N+1)"
    simplex::Array{Array{FT,1},1} = [zeros(FT,N+1) for i in 1:(N+1)]
end




"""
    struct NewtonBisectionMethod{FT}

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
    struct NewtonRaphsonMethod{FT}

# Fields
$(FIELDS)
"""
struct NewtonRaphsonMethod{FT} <: AbstractRootSolvingMethod{FT}
    "Initial guess"
    x_ini::FT
end




"""
    struct ReduceStepMethod{FT}

# Fields
$(FIELDS)
"""
struct ReduceStepMethod{FT} <: AbstractRootSolvingMethod{FT}
    "Lower bound"
    x_min::FT
    "Upper bound"
    x_max::FT
    "Initial guess"
    x_ini::FT
    "Initial step"
    Δ_ini::FT
end




"""
    struct ReduceStepMethodND{FT}

# Fields
$(FIELDS)
"""
struct ReduceStepMethodND{FT} <: AbstractRootSolvingMethod{FT}
    "Lower bound"
    x_mins::Array{FT,1}
    "Upper bound"
    x_maxs::Array{FT,1}
    "Initial guess"
    x_inis::Array{FT,1}
    "Initial step"
    Δ_inis::Array{FT,1}
end
