module ConstrainedRootSolvers

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
export create_NelderMeadMethod,
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




end # module
