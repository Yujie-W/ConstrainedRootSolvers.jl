var documenterSearchIndex = {"docs":
[{"location":"#ConstrainedRootSolvers.jl","page":"Home","title":"ConstrainedRootSolvers.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A root solver package with constraints.","category":"page"},{"location":"#Usage","page":"Home","title":"Usage","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using ConstrainedRootSolvers\n\n_f_2_solve(x) = exp(-1 * (x/2)^5) - 0.5;\n\nsol = find_zero(_f_2_solve,\n                BisectionMethod{Float64}(x_min=0, x_max=10),\n                SolutionTolerance{Float64}(0.001))\nsol = find_zero(_f_2_solve,\n                NewtonBisectionMethod{Float64}(0.0, 10.0, 2.0),\n                ResidualTolerance{Float64}(0.001))\nsol = find_zero(_f_2_solve,\n                NewtonRaphsonMethod{Float64}(2.0),\n                ResidualTolerance{Float64}(0.001))","category":"page"},{"location":"API/#API","page":"API","title":"API","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"CurrentModule = ConstrainedRootSolvers","category":"page"},{"location":"API/#Numerical-methods","page":"API","title":"Numerical methods","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"find_zero\nfind_peak","category":"page"},{"location":"API/#ConstrainedRootSolvers.find_zero","page":"API","title":"ConstrainedRootSolvers.find_zero","text":"Function to find the first root that gives a target function result of zero. If     the root does not exist, the function returns the point where the target     function is most close to zero.\n\nfind_zero(f, ms, tol; stepping)\n\ndefined at /home/runner/work/ConstrainedRootSolvers.jl/ConstrainedRootSolvers.jl/src/find_zero.jl:40.\n\nfind_zero(f, ms, tol; stepping)\n\ndefined at /home/runner/work/ConstrainedRootSolvers.jl/ConstrainedRootSolvers.jl/src/find_zero.jl:144.\n\nfind_zero(f, ms, tol; stepping)\n\ndefined at /home/runner/work/ConstrainedRootSolvers.jl/ConstrainedRootSolvers.jl/src/find_zero.jl:258.\n\nfind_zero(f, ms, tol; stepping)\n\ndefined at /home/runner/work/ConstrainedRootSolvers.jl/ConstrainedRootSolvers.jl/src/find_zero.jl:322.\n\n\n\n\n\n","category":"function"},{"location":"API/#ConstrainedRootSolvers.find_peak","page":"API","title":"ConstrainedRootSolvers.find_peak","text":"find_peak(f::F,\n          ms::AbstractCRSMethod{FT},\n          tol::AbstractTolerance{FT}\n) where {F<:Function, FT<:AbstractFloat}\n\nFind the solution, given\n\nf A function to solve\nms BisectionMethod type method struct\ntol AbstractTolerance type tolerance struct\n\nNote that to compute the lowest value, use -f to make it a peak.\n\nPossible combinations\n\nMethod Type Tolerance type Pass Test\nBisectionMethod SolutionTolerance 2 allocs\nNelderMeadMethod ResidualTolerance N+6 allocs\nNelderMeadMethod SolutionToleranceND N+6 allocs\nReduceStepMethod SolutionTolerance Yes\nReduceStepMethodND SolutionToleranceND 4 allocs\n\n\n\n\n\n","category":"function"},{"location":"API/#Method-options","page":"API","title":"Method options","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"AbstractCRSMethod\nBisectionMethod\nNelderMeadMethod\nNewtonBisectionMethod\nNewtonRaphsonMethod\nReduceStepMethod\nReduceStepMethodND","category":"page"},{"location":"API/#ConstrainedRootSolvers.AbstractCRSMethod","page":"API","title":"ConstrainedRootSolvers.AbstractCRSMethod","text":"Abstract type of the ConstrainedRootSolvers methods\n\nabstract type AbstractCRSMethod{FT<:AbstractFloat}\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.BisectionMethod","page":"API","title":"ConstrainedRootSolvers.BisectionMethod","text":"Bisection method for 1D root solvers\n\nmutable struct BisectionMethod{FT<:AbstractFloat} <: ConstrainedRootSolvers.AbstractCRSMethod{FT<:AbstractFloat}\n\nFields\n\nx_min::AbstractFloat\nlower bound\nx_max::AbstractFloat\nupper bound\nxy::Matrix{FT} where FT<:AbstractFloat\nmatrix that stores x and y\nhistory::Vector{T} where T\nhistory of all simulations\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.NelderMeadMethod","page":"API","title":"ConstrainedRootSolvers.NelderMeadMethod","text":"Nelder-Mead method for 2D and above solvers\n\nmutable struct NelderMeadMethod{FT<:AbstractFloat} <: ConstrainedRootSolvers.AbstractCRSMethod{FT<:AbstractFloat}\n\nFields\n\nN::Int64\nNumber of parameters to optimize\nx_inis::Vector{FT} where FT<:AbstractFloat\nInitial values\nsimplex::Array{Vector{FT}, 1} where FT<:AbstractFloat\nSimplex array of array with dimension (N+1) * (N+1)\ncen_x::Vector{FT} where FT<:AbstractFloat\nCentroid\nref_x::Vector{FT} where FT<:AbstractFloat\nReflection\nexp_x::Vector{FT} where FT<:AbstractFloat\nExpansion\ncon_x::Vector{FT} where FT<:AbstractFloat\nContraction\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.NewtonBisectionMethod","page":"API","title":"ConstrainedRootSolvers.NewtonBisectionMethod","text":"Newton's method constrained by mininum and maximum ranges for 1D root solver\n\nmutable struct NewtonBisectionMethod{FT<:AbstractFloat} <: ConstrainedRootSolvers.AbstractCRSMethod{FT<:AbstractFloat}\n\nFields\n\nx_min::AbstractFloat\nLower bound\nx_max::AbstractFloat\nUpper bound\nx_ini::AbstractFloat\nInitial guess\nhistory::Vector{T} where T\nhistory of all simulations\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.NewtonRaphsonMethod","page":"API","title":"ConstrainedRootSolvers.NewtonRaphsonMethod","text":"Newton raphson method for 1D root solver\n\nmutable struct NewtonRaphsonMethod{FT<:AbstractFloat} <: ConstrainedRootSolvers.AbstractCRSMethod{FT<:AbstractFloat}\n\nFields\n\nx_ini::AbstractFloat\nInitial guess\nhistory::Vector{T} where T\nhistory of all simulations\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.ReduceStepMethod","page":"API","title":"ConstrainedRootSolvers.ReduceStepMethod","text":"Reduce step method for 1D root solver. This method increases or decreases from     initial guess until no improvement is found. Then the incremantal step     decreases, and then the root solver continues.\n\nmutable struct ReduceStepMethod{FT<:AbstractFloat} <: ConstrainedRootSolvers.AbstractCRSMethod{FT<:AbstractFloat}\n\nFields\n\nx_min::AbstractFloat\nLower bound\nx_max::AbstractFloat\nUpper bound\nx_ini::AbstractFloat\nInitial guess\nΔ_ini::AbstractFloat\nInitial step\nhistory::Vector{T} where T\nhistory of all simulations\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.ReduceStepMethodND","page":"API","title":"ConstrainedRootSolvers.ReduceStepMethodND","text":"Reduce step method for 2D and above root solver. This method increases or     decreases each variable in the initial guess until no improvement is found.     Then the incremental steps decreases, and then the root solver continues.\n\nmutable struct ReduceStepMethodND{FT<:AbstractFloat} <: ConstrainedRootSolvers.AbstractCRSMethod{FT<:AbstractFloat}\n\nFields\n\nx_mins::Vector{FT} where FT<:AbstractFloat\nLower bound\nx_maxs::Vector{FT} where FT<:AbstractFloat\nUpper bound\nx_inis::Vector{FT} where FT<:AbstractFloat\nInitial guess\nx_targ::Vector{FT} where FT<:AbstractFloat\nTarget x\nx_temp::Vector{FT} where FT<:AbstractFloat\nTemporary x\nΔ_inis::Vector{FT} where FT<:AbstractFloat\nInitial step\nΔ_oper::Vector{FT} where FT<:AbstractFloat\nOperation step\nΔjd::Vector{Bool}\nArray of judges\n\n\n\n\n\n","category":"type"},{"location":"API/#Tolerance-options","page":"API","title":"Tolerance options","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"AbstractTolerance\nResidualTolerance\nSolutionTolerance\nSolutionToleranceND\nif_break\nnext_xy!","category":"page"},{"location":"API/#ConstrainedRootSolvers.AbstractTolerance","page":"API","title":"ConstrainedRootSolvers.AbstractTolerance","text":"Abstract tolerance type\n\nabstract type AbstractTolerance{FT}\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.ResidualTolerance","page":"API","title":"ConstrainedRootSolvers.ResidualTolerance","text":"Tolerance for target function residual\n\nstruct ResidualTolerance{FT} <: ConstrainedRootSolvers.AbstractTolerance{FT}\n\nFields\n\ntol::Any\nTolerance for residual\nn_limit::Int64\nlimit of iterations\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.SolutionTolerance","page":"API","title":"ConstrainedRootSolvers.SolutionTolerance","text":"Tolerance for solution\n\nstruct SolutionTolerance{FT} <: ConstrainedRootSolvers.AbstractTolerance{FT}\n\nFields\n\ntol::Any\nTolerance for solution\nn_limit::Int64\nlimit of iterations\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.SolutionToleranceND","page":"API","title":"ConstrainedRootSolvers.SolutionToleranceND","text":"Tolerance for 2D and above solution\n\nstruct SolutionToleranceND{FT} <: ConstrainedRootSolvers.AbstractTolerance{FT}\n\nFields\n\ntol::Vector{FT} where FT\nTolerance for solution\nn_limit::Int64\nlimit of iterations\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.if_break","page":"API","title":"ConstrainedRootSolvers.if_break","text":"Determine whether to stopping finding the solution depending on the tolerance     type.\n\nif_break(tol, x1, x2, y, n)\n\ndefined at /home/runner/work/ConstrainedRootSolvers.jl/ConstrainedRootSolvers.jl/src/tolerance.jl:118.\n\nif_break(tol, x1, x2, y, n)\n\ndefined at /home/runner/work/ConstrainedRootSolvers.jl/ConstrainedRootSolvers.jl/src/tolerance.jl:148.\n\n\n\n\n\n","category":"function"},{"location":"API/#ConstrainedRootSolvers.next_xy!","page":"API","title":"ConstrainedRootSolvers.next_xy!","text":"next_xy!(f::F, xy::Array{FT,2}) where {F<:Function, FT<:AbstractFloat}\n\nDetermine the next points to, given\n\nf Function to find peak\nxy Array of x and y\n\n\n\n\n\n","category":"function"}]
}
