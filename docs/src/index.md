# ConstrainedRootSolvers.jl
A root solver package with constraints.

## Usage
```julia
using ConstrainedRootSolvers

_f_2_solve(x) = exp(-1 * (x/2)^5) - 0.5;

sol = find_zero(_f_2_solve,
                BisectionMethod{Float64}(x_min=0, x_max=10),
                SolutionTolerance{Float64}(0.001))
sol = find_zero(_f_2_solve,
                NewtonBisectionMethod{Float64}(0.0, 10.0, 2.0),
                ResidualTolerance{Float64}(0.001))
sol = find_zero(_f_2_solve,
                NewtonRaphsonMethod{Float64}(2.0),
                ResidualTolerance{Float64}(0.001))
```
