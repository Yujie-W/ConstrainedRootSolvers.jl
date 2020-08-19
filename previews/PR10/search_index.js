var documenterSearchIndex = {"docs":
[{"location":"#ConstrainedRootSolvers.jl","page":"Home","title":"ConstrainedRootSolvers.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"A root solver package with constraints.","category":"page"},{"location":"#Usage","page":"Home","title":"Usage","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"using ConstrainedRootSolvers\n\n_f_2_solve(x) = exp(-1 * (x/2)^5) - 0.5;\n\nsol = find_zero(_f_2_solve,\n                BisectionMethod{Float64}(0.0, 10.0),\n                SolutionTolerance{Float64}(0.001))\nsol = find_zero(_f_2_solve,\n                NewtonBisectionMethod{Float64}(0.0, 10.0, 2.0),\n                ResidualTolerance{Float64}(0.001))\nsol = find_zero(_f_2_solve,\n                NewtonRaphsonMethod{Float64}(2.0),\n                ResidualTolerance{Float64}(0.001))","category":"page"},{"location":"API/#API","page":"API","title":"API","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"CurrentModule = ConstrainedRootSolvers","category":"page"},{"location":"API/#Numerical-methods","page":"API","title":"Numerical methods","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"find_zero\nfind_peak","category":"page"},{"location":"API/#ConstrainedRootSolvers.find_zero","page":"API","title":"ConstrainedRootSolvers.find_zero","text":"find_zero(f::F, ms::AbstractRootSolvingMethod{FT}, tol::AbstractTolerance{FT}) where {F<:Function, FT<:AbstractFloat}\n\nFind the solution, given\n\nf Function to solve\nms AbstractRootSolvingMethod type method struct\ntol AbstractTolerance type tolerance struct\n\nPossible combinations\n\nMethod Type Tolerance Type Pass Test\nBisectionMethod ResidualTolerance Yes\nBisectionMethod SolutionTolerance Yes\nNewtonBisectionMethod ResidualTolerance Yes\nNewtonBisectionMethod SolutionTolerance Yes\nNewtonRaphsonMethod ResidualTolerance Yes\nNewtonRaphsonMethod SolutionTolerance Yes\nReduceStepMethod ResidualTolerance Yes\nReduceStepMethod SolutionTolerance Yes\n\n\n\n\n\n","category":"function"},{"location":"API/#ConstrainedRootSolvers.find_peak","page":"API","title":"ConstrainedRootSolvers.find_peak","text":"find_peak(f::F, ms::AbstractRootSolvingMethod{FT}, tol::AbstractTolerance{FT}) where {F<:Function, FT<:AbstractFloat}\n\nFind the solution, given\n\nf A function to solve\nms BisectionMethod type method struct\ntol AbstractTolerance type tolerance struct\n\nNote that to compute the lowest value, use -f to make it a peak.\n\nPossible combinations\n\nMethod Type Tolerance type Pass Test\nBisectionMethod SolutionTolerance 2 allocs\nNelderMeadMethod ResidualTolerance N+6 allocs\nNelderMeadMethod SolutionToleranceND N+6 allocs\nReduceStepMethod SolutionTolerance Yes\nReduceStepMethodND SolutionToleranceND 4 allocs\n\n\n\n\n\n","category":"function"},{"location":"API/#Method-options","page":"API","title":"Method options","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"AbstractRootSolvingMethod\nBisectionMethod\nNelderMeadMethod\nNewtonBisectionMethod\nNewtonRaphsonMethod\nReduceStepMethod\nReduceStepMethodND","category":"page"},{"location":"API/#ConstrainedRootSolvers.AbstractRootSolvingMethod","page":"API","title":"ConstrainedRootSolvers.AbstractRootSolvingMethod","text":"Hierachy of AbstractRootSolvingMethod:\n\nBisectionMethod\nNelderMeadMethod\nNewtonBisectionMethod\nNewtonRaphsonMethod\nReduceStepMethod\nReduceStepMethodND\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.BisectionMethod","page":"API","title":"ConstrainedRootSolvers.BisectionMethod","text":"struct BisectionMethod{FT}\n\nFields\n\nx_min\nlower bound\nx_max\nupper bound\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.NelderMeadMethod","page":"API","title":"ConstrainedRootSolvers.NelderMeadMethod","text":"struct NelderMeadMethod{FT}\n\nFields\n\nN\nNumber of parameters to optimize\nx_inis\nInitial values\nsimplex\nSimplex array of array with dimension (N+1) * (N+1)\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.NewtonBisectionMethod","page":"API","title":"ConstrainedRootSolvers.NewtonBisectionMethod","text":"struct NewtonBisectionMethod{FT}\n\nFields\n\nx_min\nLower bound\nx_max\nUpper bound\nx_ini\nInitial guess\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.NewtonRaphsonMethod","page":"API","title":"ConstrainedRootSolvers.NewtonRaphsonMethod","text":"struct NewtonRaphsonMethod{FT}\n\nFields\n\nx_ini\nInitial guess\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.ReduceStepMethod","page":"API","title":"ConstrainedRootSolvers.ReduceStepMethod","text":"struct ReduceStepMethod{FT}\n\nFields\n\nx_min\nLower bound\nx_max\nUpper bound\nx_ini\nInitial guess\nΔ_ini\nInitial step\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.ReduceStepMethodND","page":"API","title":"ConstrainedRootSolvers.ReduceStepMethodND","text":"struct ReduceStepMethodND{FT}\n\nFields\n\nx_mins\nLower bound\nx_maxs\nUpper bound\nx_inis\nInitial guess\nΔ_inis\nInitial step\n\n\n\n\n\n","category":"type"},{"location":"API/#Tolerance-options","page":"API","title":"Tolerance options","text":"","category":"section"},{"location":"API/","page":"API","title":"API","text":"AbstractTolerance\nResidualTolerance\nSolutionTolerance\nSolutionToleranceND\nif_break_uni\nnext_xy!","category":"page"},{"location":"API/#ConstrainedRootSolvers.AbstractTolerance","page":"API","title":"ConstrainedRootSolvers.AbstractTolerance","text":"Hierachy of AbstractTolerance:\n\nResidualTolerance\nSolutionTolerance\nStepTolerance\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.ResidualTolerance","page":"API","title":"ConstrainedRootSolvers.ResidualTolerance","text":"struct ResidualTolerance{FT}\n\nFields\n\ntol\nTolerance for residual\nn_limit\nlimit of iterations\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.SolutionTolerance","page":"API","title":"ConstrainedRootSolvers.SolutionTolerance","text":"struct SolutionTolerance{FT}\n\nFields\n\ntol\nTolerance for solution\nn_limit\nlimit of iterations\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.SolutionToleranceND","page":"API","title":"ConstrainedRootSolvers.SolutionToleranceND","text":"struct SolutionToleranceND{FT}\n\nFields\n\ntol\nTolerance for solution\nn_limit\nlimit of iterations\n\n\n\n\n\n","category":"type"},{"location":"API/#ConstrainedRootSolvers.if_break_uni","page":"API","title":"ConstrainedRootSolvers.if_break_uni","text":"if_break_uni(tol::SolutionTolerance{FT}, x1::FT, x2::FT, y::FT) where {FT<:AbstractFloat}\nif_break_uni(tol::ResidualTolerance{FT}, x1::FT, x2::FT, y::FT) where {FT<:AbstractFloat}\n\nDetermine whether to break, given\n\ntol ResidualTolerance or SolutionTolerance type tolerance struct\nx1 Lower bound of x\nx2 Upper bound of x\ny Residual of y\nn Current iteration\n\n\n\n\n\n","category":"function"},{"location":"API/#ConstrainedRootSolvers.next_xy!","page":"API","title":"ConstrainedRootSolvers.next_xy!","text":"next_xy!(f::F, xy::Array{FT,2})\n\nDetermine the next points to, given\n\nf Function to find peak\nxy Array of x and y\n\n\n\n\n\n","category":"function"}]
}