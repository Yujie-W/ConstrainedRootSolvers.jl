# ConstrainedRootSolvers.jl

Typical algorithms for root finding often do not work for plants because of the
    wierd shape of curves. In many cases, chosing a good initial guess works.
    But in many case, the initial guess may result in error. Here, customized
    root finding algorithms are presented with constaints. The package only
    support the latest stable Julia version, you need to adapt the `julia = *`
    to make it work for other versions of Julia.

| Documentation                                   | CI Status             | Benchmarks            |
|:-----------------------------------------------:|:---------------------:|:---------------------:|
| [![][dev-img]][dev-url] [![][rel-img]][rel-url] | [![][st-img]][st-url] | [![][bm-img]][bm-url] |

[dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[dev-url]: https://Yujie-W.github.io/ConstrainedRootSolvers.jl/dev/

[rel-img]: https://img.shields.io/badge/docs-stable-blue.svg
[rel-url]: https://Yujie-W.github.io/ConstrainedRootSolvers.jl/stable/

[st-img]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/workflows/JuliaStable/badge.svg?branch=master
[st-url]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/actions?query=branch%3A"master"++workflow%3A"JuliaStable"

[bm-img]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/workflows/Benchmarks/badge.svg?branch=master
[bm-url]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/actions?query=branch%3A"master"++workflow%3A"Benchmarks"
