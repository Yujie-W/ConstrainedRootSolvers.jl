###############################################################################
#
# Root finding method
#
###############################################################################
"""
    abstract type AbstractCRSMethod{FT}

Hierachy of AbstractCRSMethod:
- BisectionMethod
- NelderMeadMethod
- NewtonBisectionMethod
- NewtonRaphsonMethod
- ReduceStepMethod
- ReduceStepMethodND
"""
abstract type AbstractCRSMethod{FT} end




"""
    mutable struct BisectionMethod{FT}

# Fields
$(FIELDS)
"""
Base.@kwdef mutable struct BisectionMethod{FT} <: AbstractCRSMethod{FT}
    "lower bound"
    x_min::FT = FT(0)
    "upper bound"
    x_max::FT = FT(1)
    "matrix that stores x and y"
    xy::Array{FT,2} = FT[x_min 0; (x_min+x_max)/2 0; x_max 0]
end




"""
    mutable struct NelderMeadMethod{FT}

# Fields
$(FIELDS)
"""
Base.@kwdef mutable struct NelderMeadMethod{FT} <: AbstractCRSMethod{FT}
    "Number of parameters to optimize"
    N::Int = 2
    "Initial values"
    x_inis::Array{FT,1} = zeros(FT,N+1)
    "Simplex array of array with dimension (N+1) * (N+1)"
    simplex::Array{Array{FT,1},1} = [zeros(FT,N+1) for i in 1:(N+1)]

    # temporary containers
    "Centroid"
    cen_x::Array{FT,1} = deepcopy(x_inis)
    "Reflection"
    ref_x::Array{FT,1} = deepcopy(x_inis)
    "Expansion"
    exp_x::Array{FT,1} = deepcopy(x_inis)
    "Contraction"
    con_x::Array{FT,1} = deepcopy(x_inis)
end




"""
    struct NewtonBisectionMethod{FT}

# Fields
$(FIELDS)
"""
struct NewtonBisectionMethod{FT} <: AbstractCRSMethod{FT}
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
struct NewtonRaphsonMethod{FT} <: AbstractCRSMethod{FT}
    "Initial guess"
    x_ini::FT
end




"""
    struct ReduceStepMethod{FT}

# Fields
$(FIELDS)
"""
struct ReduceStepMethod{FT} <: AbstractCRSMethod{FT}
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
    mutable struct ReduceStepMethodND{FT}

# Fields
$(FIELDS)
"""
Base.@kwdef mutable struct ReduceStepMethodND{FT} <: AbstractCRSMethod{FT}
    "Lower bound"
    x_mins::Array{FT,1} = zeros(FT,2)
    "Upper bound"
    x_maxs::Array{FT,1} =  ones(FT,2)
    "Initial guess"
    x_inis::Array{FT,1} = FT[0.5, 0.5]
    "Target x"
    x_targ::Array{FT,1} = deepcopy(x_inis)
    "Temporary x"
    x_temp::Array{FT,1} = deepcopy(x_inis)
    "Initial step"
    Δ_inis::Array{FT,1} = FT[0.1, 0.1]
    "Operation step"
    Δ_oper::Array{FT,1} = deepcopy(Δ_inis)
    "Array of judges"
    Δjd::Array{Bool,1} = [false for i in 1:length(x_inis)]
end
