using BenchmarkTools
using ConstrainedRootSolvers
using Test




@testset "ConstrainedRootSolvers --- find_peak" begin
    # segmented function with solution 1
    # segmented function with solution 1
    # segmented function with solution of upper end
    # segmented function with solution 1
    # segmented function with solution of lower bound
    # segmented function with solution 1
    # surface function
    @inline function _f0(x::FT) where {FT<:AbstractFloat}
        return x>1 ? FT(1) : x
    end
    @inline function _f1(x::FT) where {FT<:AbstractFloat}
        return x>1 ? 2-x : x
    end
    @inline function _f2(x::FT) where {FT<:AbstractFloat}
        return x>1 ? (1+x)/2 : x
    end
    @inline function _f3(x::FT) where {FT<:AbstractFloat}
        return x>1 ? 2-x : FT(0)
    end
    @inline function _f4(x::FT) where {FT<:AbstractFloat}
        return x>1 ? 2-x : FT(1)
    end
    @inline function _f5(x::FT) where {FT<:AbstractFloat}
        return x>1 ? FT(0.5) : x
    end
    @inline function _surf_func(x::Array{FT,1}) where {FT<:AbstractFloat}
        return -(x[1]-2)^2 - (x[2]-3)^2
    end

    lr = [1, 1, 5, 1, 0, 1];
    lf = [_f0, _f1, _f2, _f3, _f4, _f5];

    for FT in [Float32, Float64]
        # Bisection method
        # ReduceStep method
        ms_bis = BisectionMethod{FT}(x_min=0, x_max=5);
        ms_rst = ReduceStepMethod{FT}(0, 5, 1+rand(FT), 1);
        st = SolutionTolerance{FT}(1e-3, 50);
        for ms in [ms_bis, ms_rst]
            for i in 1:6
                sol = find_peak(lf[i], ms, st);
                @test !isnan(sol);
                @test typeof(sol) == FT;
                @test sol ≈ lr[i] atol=0.01;
            end
        end
    end

    for FT in [Float32, Float64]
        # NelderMeadMethod method
        # ReduceStepND method
        ms_sim = NelderMeadMethod{FT}(
                        N = 2,
                        x_inis = FT[rand(FT)+1, rand(FT)+2, 0]);
        ms_rst = ReduceStepMethodND{FT}(
                        x_mins = FT[0,0],
                        x_maxs = FT[5,5],
                        x_inis = [1+rand(FT), 2+rand(FT)],
                        Δ_inis = FT[1,1]);
        rt = ResidualTolerance{FT}(1e-5, 50);
        st = SolutionToleranceND{FT}(FT[1e-3, 1e-3], 50);
        for sol in [ find_peak(_surf_func, ms_sim, rt),
                     find_peak(_surf_func, ms_sim, st),
                     find_peak(_surf_func, ms_rst, st) ]
            @test all( .!isnan.(sol) );
            @test eltype(sol) == FT;
            @test sol[1] ≈ 2 atol=0.01;
            @test sol[2] ≈ 3 atol=0.01;
        end
    end
end




@testset "ConstrainedRootSolvers --- find_zero" begin
    # A S-shape function, e.g. Weibull function
    # A R-shape function
    @inline function _r_func(x::FT) where {FT<:AbstractFloat}
        return exp( -1 * (x/2) ^ FT(0.8) ) - FT(0.5)
    end
    @inline function _s_func(x::FT) where {FT<:AbstractFloat}
        return exp( -1 * (x/2) ^ 5 ) - FT(0.5)
    end

    for FT in [Float32, Float64]
        rt = ResidualTolerance{FT}(1e-3, 50);
        st = SolutionTolerance{FT}(1e-3, 50);

        # Bisection method
        # NewtonBisection method
        # NewtonRaphson method
        # ReduceStep method
        ms_bis = BisectionMethod{FT}(x_min=0, x_max=5);
        ms_nbs = NewtonBisectionMethod{FT}(0, 5, 1+rand(FT));
        ms_ntr = NewtonRaphsonMethod{FT}(2);
        ms_rst = ReduceStepMethod{FT}(0, 5, 1+rand(FT), 1);

        for ms in [ms_bis, ms_nbs, ms_ntr, ms_rst]
            for tol in [rt, st]
                for f in [_r_func, _s_func]
                    sol = find_zero(f, ms, tol);
                    @test !isnan(sol);
                    @test typeof(sol) == FT;
                end
            end
        end
    end
end
