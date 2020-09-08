# ConstrainedRootSolvers.jl

<!-- Links and shortcuts -->
[rs-url]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl
[rs-api]: https://yujie-w.github.io/ConstrainedRootSolvers.jl/stable/API/

[dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[dev-url]: https://Yujie-W.github.io/ConstrainedRootSolvers.jl/dev/

[rel-img]: https://img.shields.io/badge/docs-stable-blue.svg
[rel-url]: https://Yujie-W.github.io/ConstrainedRootSolvers.jl/stable/

[st-img]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/workflows/JuliaStable/badge.svg?branch=master
[st-url]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/actions?query=branch%3A"master"++workflow%3A"JuliaStable"

[min-img]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/workflows/Julia-1.3/badge.svg?branch=master
[min-url]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/actions?query=branch%3A"master"++workflow%3A"Julia-1.3"

[bm-img]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/workflows/Benchmarks/badge.svg?branch=master
[bm-url]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/actions?query=branch%3A"master"++workflow%3A"Benchmarks"

[cov-img]: https://codecov.io/gh/Yujie-W/ConstrainedRootSolvers.jl/branch/master/graph/badge.svg
[cov-url]: https://codecov.io/gh/Yujie-W/ConstrainedRootSolvers.jl

# About

Typical algorithms for root finding often do not work for plants because of the wierd shape of curves. In many cases, chosing a good initial guess works. But in many case, the initial guess may result in error. Here, customized root finding algorithms are presented with constaints. Due to the dependency on `Base.@kwdef`, [`ConstrainedRootSolvers.jl`][rs-url] only spports Julia 1.3 and above.

| Documentation                                   | CI Status             | Benchmarks            | Compatibility           | Code Coverage           |
|:------------------------------------------------|:----------------------|:----------------------|:------------------------|:------------------------|
| [![][dev-img]][dev-url] [![][rel-img]][rel-url] | [![][st-img]][st-url] | [![][bm-img]][bm-url] | [![][min-img]][min-url] | [![][cov-img]][cov-url] |




## Dependencies

| Dependency             | Version  | Requirements |
|:-----------------------|:---------|:-------------|
| BenchmarkTools         | 0.5.0 +  | Julia 1.0 +  |
| DocStringExtensions    | 0.8.3 +  | Julia 0.7 +  |
| Parameters             | 0.12.1 + | Julia 1.0 +  |
| ConstrainedRootSolvers |          | Julia 1.3 +  |




## Installation
```julia
julia> using Pkg;
julia> Pkg.add("ConstrainedRootSolvers");
```




## API
See [`API`][rs-api] for more detailed information about how to use [`ConstrainedRootSolvers.jl`][rs-url].
