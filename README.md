# ConstrainedRootSolvers.jl

Typical algorithms for root finding often do not work for plants because of the wierd shape of curves. In many cases, chosing a good initial guess works. But in many case, the initial guess may result in error. Here, customized root finding algorithms are presented with constaints.

| Documentation                                                       | CI Status                                   | Benchmarks            |
|:-------------------------------------------------------------------:|:-------------------------------------------:|:---------------------:|
| [![][docs-dev-img]][docs-dev-url] [![][docs-rel-img]][docs-rel-url] | [![][st-img]][st-url] [![][lt-img]][lt-url] | [![][bm-img]][bm-url] |

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://Yujie-W.github.io/ConstrainedRootSolvers.jl/dev/

[docs-rel-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-rel-url]: https://Yujie-W.github.io/ConstrainedRootSolvers.jl/stable/

[st-img]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/workflows/JuliaStable/badge.svg?branch=master
[st-url]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/actions?query=branch%3A"master"++workflow%3A"JuliaStable"

[lt-img]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/workflows/JuliaLTS/badge.svg?branch=master
[lt-url]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/actions?query=branch%3A"master"++workflow%3A"JuliaLTS"

[bm-img]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/workflows/Benchmarks/badge.svg?branch=master
[bm-url]: https://github.com/Yujie-W/ConstrainedRootSolvers.jl/actions?query=branch%3A"master"++workflow%3A"Benchmarks"
