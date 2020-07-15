using BenchmarkTools
using ConstrainedRootSolvers
using Test




# A S-shape function, e.g. Weibull function
function _r_func(x::FT) where {FT<:AbstractFloat}
    return exp( -1 * (x/2) ^ FT(0.8) ) - FT(0.5)
end

# A R-shape function
function _s_func(x::FT) where {FT<:AbstractFloat}
    return exp( -1 * (x/2) ^ 5 ) - FT(0.5)
end

# segmented function with solution 1
function _f0(x::FT) where {FT<:AbstractFloat}
    return x>1 ? FT(1) : x
end

# segmented function with solution 1
function _f1(x::FT) where {FT<:AbstractFloat}
    return x>1 ? 2-x : x
end

# segmented function with solution of upper end
function _f2(x::FT) where {FT<:AbstractFloat}
    return x>1 ? (1+x)/2 : x
end

# segmented function with solution 1
function _f3(x::FT) where {FT<:AbstractFloat}
    return x>1 ? 2-x : FT(0)
end

# segmented function with solution of lower bound
function _f4(x::FT) where {FT<:AbstractFloat}
    return x>1 ? 2-x : FT(1)
end

# segmented function with solution 1
function _f5(x::FT) where {FT<:AbstractFloat}
    return x>1 ? FT(0.5) : x
end

# surface function
function _surf_func(x::Array{FT,1}) where {FT<:AbstractFloat}
    return -(x[1]-2)^2 - (x[2]-3)^2
end




# Benchmarked already
benchmarking = false

include("test_findzero_bisection.jl"      );
include("test_findzero_newtonbisection.jl");
include("test_findzero_newtonraphson.jl"  );
include("test_findzero_reducestep.jl"     );

include("test_findpeak_bisection.jl"   );
include("test_findpeak_neldermead.jl"  );
include("test_findpeak_reducestep.jl"  );
include("test_findpeak_reducestepND.jl");

# To be benchmarked
benchmarking = true
