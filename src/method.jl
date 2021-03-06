###############################################################################
#
# Root finding method
#
###############################################################################
"""
Abstract type of the ConstrainedRootSolvers methods

$(TYPEDEF)

"""
abstract type AbstractCRSMethod{FT<:AbstractFloat} end




"""
Bisection method for 1D root solvers

$(TYPEDEF)

# Fields

$(TYPEDFIELDS)

"""
Base.@kwdef mutable struct BisectionMethod{FT<:AbstractFloat} <:
                           AbstractCRSMethod{FT}
    "lower bound"
    x_min::FT = 0
    "upper bound"
    x_max::FT = 0
    "matrix that stores x and y"
    xy::Matrix{FT} = FT[x_min 0; (x_min+x_max)/2 0; x_max 0]

    # history Vector
    "history of all simulations"
    history::Vector = Vector{FT}[]
end




"""
Nelder-Mead method for 2D and above solvers

$(TYPEDEF)

# Fields

$(TYPEDFIELDS)

"""
Base.@kwdef mutable struct NelderMeadMethod{FT<:AbstractFloat} <:
                           AbstractCRSMethod{FT}
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
Newton's method constrained by mininum and maximum ranges for 1D root solver

$(TYPEDEF)

# Fields

$(TYPEDFIELDS)

"""
Base.@kwdef mutable struct NewtonBisectionMethod{FT<:AbstractFloat} <:
                           AbstractCRSMethod{FT}
    "Lower bound"
    x_min::FT = 0
    "Upper bound"
    x_max::FT = 1
    "Initial guess"
    x_ini::FT = (x_min + x_max) / 2

    # history Vector
    "history of all simulations"
    history::Vector = Vector{FT}[]
end




"""
Newton raphson method for 1D root solver

$(TYPEDEF)

# Fields

$(TYPEDFIELDS)

"""
Base.@kwdef mutable struct NewtonRaphsonMethod{FT<:AbstractFloat} <:
                           AbstractCRSMethod{FT}
    "Initial guess"
    x_ini::FT

    # history Vector
    "history of all simulations"
    history::Vector = Vector{FT}[]
end




"""
Reduce step method for 1D root solver. This method increases or decreases from
    initial guess until no improvement is found. Then the incremantal step
    decreases, and then the root solver continues.

$(TYPEDEF)

# Fields

$(TYPEDFIELDS)

"""
Base.@kwdef mutable struct ReduceStepMethod{FT<:AbstractFloat} <:
                           AbstractCRSMethod{FT}
    "Lower bound"
    x_min::FT = 0
    "Upper bound"
    x_max::FT = 1
    "Initial guess"
    x_ini::FT = (x_min + x_max) / 2
    "Initial step"
    Δ_ini::FT = (x_min + x_max) / 10

    # history Vector
    "history of all simulations"
    history::Vector = Vector{FT}[]
end




"""
Reduce step method for 2D and above root solver. This method increases or
    decreases each variable in the initial guess until no improvement is found.
    Then the incremental steps decreases, and then the root solver continues.

$(TYPEDEF)

# Fields

$(TYPEDFIELDS)

"""
Base.@kwdef mutable struct ReduceStepMethodND{FT<:AbstractFloat} <:
                           AbstractCRSMethod{FT}
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
