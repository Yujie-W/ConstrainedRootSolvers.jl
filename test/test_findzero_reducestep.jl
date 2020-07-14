# test find_zero function using ReduceStep method
println("Testing find_zero with ReduceStep method...");
@testset "find_zero --- ReduceStep method" begin
    for FT in [Float32, Float64]
        ms = ReduceStepMethod{FT}(FT[0],FT[5],FT[2],FT[1]);
        rt = ResidualTolerance{FT}(FT[1e-3], 50);
        st = SolutionTolerance{FT}(1e-3, 50);
        tt = StepTolerance{FT}(FT[1e-3]);

        for tol in [rt, st, tt]
            for f in [_r_func, _s_func]
                sol = find_zero(f, ms, tol);
                @test !isnan(sol);
                @test typeof(sol) == FT;
            end
        end

        @show FT;
        @btime find_zero(_r_func, $ms, $rt);
        @btime find_zero(_r_func, $ms, $st);
        @btime find_zero(_r_func, $ms, $tt);
        @btime find_zero(_s_func, $ms, $rt);
        @btime find_zero(_s_func, $ms, $st);
        @btime find_zero(_s_func, $ms, $tt);
    end
end
