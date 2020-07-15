# test find_zero function using Bisection method
println("\nTesting find_zero with Bisection method...");
@testset "find_zero --- Bisection method" begin
    for FT in [Float32, Float64]
        ms = BisectionMethod{FT}(0,5);
        rt = ResidualTolerance{FT}(1e-3, 50);
        st = SolutionTolerance{FT}(1e-3, 50);

        for tol in [rt, st]
            for f in [_r_func, _s_func]
                sol = find_zero(f, ms, tol);
                @test !isnan(sol);
                @test typeof(sol) == FT;
            end
        end

        if benchmarking
            @show FT;
            @btime find_zero(_r_func, $ms, $rt);
            @btime find_zero(_r_func, $ms, $st);
            @btime find_zero(_s_func, $ms, $rt);
            @btime find_zero(_s_func, $ms, $st);
        end
    end
end
