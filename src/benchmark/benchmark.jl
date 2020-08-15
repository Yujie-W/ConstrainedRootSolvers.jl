###############################################################################
#
# Benchmark the Package
#
###############################################################################
"""



"""
function benchmark_ConstrainedRootSolvers(FT)
    # A S-shape function, e.g. Weibull function
    @inline function _r_func(x::FT) where {FT<:AbstractFloat}
        return exp( -1 * (x/2) ^ FT(0.8) ) - FT(0.5)
    end

    # A R-shape function
    @inline function _s_func(x::FT) where {FT<:AbstractFloat}
        return exp( -1 * (x/2) ^ 5 ) - FT(0.5)
    end

    # segmented function with solution 1
    @inline function _f0(x::FT) where {FT<:AbstractFloat}
        return x>1 ? FT(1) : x
    end

    # segmented function with solution 1
    @inline function _f1(x::FT) where {FT<:AbstractFloat}
        return x>1 ? 2-x : x
    end

    # segmented function with solution of upper end
    @inline function _f2(x::FT) where {FT<:AbstractFloat}
        return x>1 ? (1+x)/2 : x
    end

    # segmented function with solution 1
    @inline function _f3(x::FT) where {FT<:AbstractFloat}
        return x>1 ? 2-x : FT(0)
    end

    # segmented function with solution of lower bound
    @inline function _f4(x::FT) where {FT<:AbstractFloat}
        return x>1 ? 2-x : FT(1)
    end

    # segmented function with solution 1
    @inline function _f5(x::FT) where {FT<:AbstractFloat}
        return x>1 ? FT(0.5) : x
    end

    # surface function
    @inline function _surf_func(x::Array{FT,1}) where {FT<:AbstractFloat}
        return -(x[1]-2)^2 - (x[2]-3)^2
    end

    println("\nBenchmarking find_peak with Bisection method...");
    ms = BisectionMethod{FT}(0, 5);
    st = SolutionTolerance{FT}(1e-3, 50);
    lr = [1, 1, 5, 1, 0, 1]
    lf = [_f0, _f1, _f2, _f3, _f4, _f5]
    for f in lf
        @btime find_peak($f, $ms, $st);
    end

    println("\nBenchmarking find_peak with NelderMeadMethod method...");
    ms = NelderMeadMethod{FT}(N=2, x_inis=FT[rand(FT)+1, rand(FT)+2, 0]);
    rt = ResidualTolerance{FT}(1e-5, 50);
    st = SolutionToleranceND{FT}(FT[1e-3, 1e-3], 50);
    @btime find_peak($_surf_func, $ms, $rt);
    @btime find_peak($_surf_func, $ms, $st);

    println("\nBenchmarking find_peak with ReduceStepMethod method...");
    ms = ReduceStepMethod{FT}(0, 5, 1+rand(FT), 1);
    st = SolutionTolerance{FT}(1e-3, 50);
    lr = [1, 1, 5, 1, 0, 1]
    lf = [_f0, _f1, _f2, _f3, _f4, _f5]
    for f in lf
        @btime find_peak($f, $ms, $st);
    end

    println("\nBenchmarking find_peak with ReduceStepMethodND method...");
    ms = ReduceStepMethodND{FT}(FT[0,0], FT[5,5], [1+rand(FT), 2+rand(FT)], FT[1,1]);
    st = SolutionToleranceND{FT}(FT[1e-3, 1e-3], 50);
    @btime find_peak($_surf_func, $ms, $st);

    println("\nBenchmarking find_zero with BisectionMethod method...");
    ms = BisectionMethod{FT}(0,5);
    rt = ResidualTolerance{FT}(1e-3, 50);
    st = SolutionTolerance{FT}(1e-3, 50);
    @btime find_zero($_r_func, $ms, $rt);
    @btime find_zero($_r_func, $ms, $st);
    @btime find_zero($_s_func, $ms, $rt);
    @btime find_zero($_s_func, $ms, $st);

    println("\nBenchmarking find_zero with NewtonBisectionMethod method...");
    ms = NewtonBisectionMethod{FT}(0, 5, 1+rand(FT));
    rt = ResidualTolerance{FT}(1e-3, 50);
    st = SolutionTolerance{FT}(1e-3, 50);
    @btime find_zero($_r_func, $ms, $rt);
    @btime find_zero($_r_func, $ms, $st);
    @btime find_zero($_s_func, $ms, $rt);
    @btime find_zero($_s_func, $ms, $st);

    println("\nBenchmarking find_zero with NewtonRaphsonMethod method...");
    ms = NewtonRaphsonMethod{FT}(2);
    rt = ResidualTolerance{FT}(1e-3, 50);
    st = SolutionTolerance{FT}(1e-3, 50);
    @btime find_zero($_r_func, $ms, $rt);
    @btime find_zero($_r_func, $ms, $st);
    @btime find_zero($_s_func, $ms, $rt);
    @btime find_zero($_s_func, $ms, $st);

    println("\nBenchmarking find_zero with ReduceStepMethod method...");
    ms = ReduceStepMethod{FT}(0, 5, 1+rand(FT), 1);
    rt = ResidualTolerance{FT}(1e-3, 50);
    st = SolutionTolerance{FT}(1e-3, 50);
    @btime find_zero($_r_func, $ms, $rt);
    @btime find_zero($_r_func, $ms, $st);
    @btime find_zero($_s_func, $ms, $rt);
    @btime find_zero($_s_func, $ms, $st);

    return nothing
end
