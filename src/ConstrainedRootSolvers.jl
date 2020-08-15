module ConstrainedRootSolvers

using BenchmarkTools
using DocStringExtensions
using Parameters




# export public Types
export BisectionMethod,
       NelderMeadMethod,
       NewtonBisectionMethod,
       NewtonRaphsonMethod,
       ReduceStepMethod,
       ReduceStepMethodND,
       ResidualTolerance,
       SolutionTolerance,
       SolutionToleranceND




# export public functions
export benchmark_ConstrainedRootSolvers,
       find_peak,
       find_zero




include("types/method.jl"   )
include("types/tolerance.jl")

include("break/ifbreak.jl")

include("findpeak/bisection.jl"   )
include("findpeak/neldermead.jl"  )
include("findpeak/reducestep.jl"  )
include("findpeak/reducestepND.jl")

include("findzero/bisection.jl"      )
include("findzero/newtonbisection.jl")
include("findzero/newtonraphson.jl"  )
include("findzero/reducestep.jl"     )

include("benchmark/benchmark.jl")




end # module
