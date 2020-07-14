module ConstrainedRootSolvers

using DocStringExtensions
using Parameters

export BisectionMethod,
       NelderMeadmethod,
       NewtonBisectionMethod,
       NewtonRaphsonMethod,
       ReduceStepMethod,
       ResidualTolerance,
       SolutionTolerance,
       StepTolerance

export find_peak,
       find_zero




include("types/method.jl"   )
include("types/tolerance.jl")

include("break/ifbreak.jl")

include("findpeak/bisection.jl" )
include("findpeak/reducestep.jl")

include("findzero/bisection.jl"      )
include("findzero/newtonbisection.jl")
include("findzero/newtonraphson.jl"  )
include("findzero/reducestep.jl"     )




end # module
