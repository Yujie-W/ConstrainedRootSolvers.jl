# test find_zero function using ReduceStep method
println("\nTesting find_zero with ReduceStep method...");
@testset "find_zero --- ReduceStep method" begin
    for FT in [Float32, Float64]
        ms = ReduceStepMethod{FT}(0, 5, 1+rand(FT), 1);
        rt = ResidualTolerance{FT}(1e-3, 50);
        st = SolutionTolerance{FT}(1e-3, 50);

        for tol in [rt, st]
            for f in [_r_func, _s_func]
                sol = find_zero(f, ms, tol);
                @test !isnan(sol);
                @test typeof(sol) == FT;
            end
        end
    end
end
