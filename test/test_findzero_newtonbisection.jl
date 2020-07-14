# test find_zero function using NewtonBisection method
println("Testing find_zero with Newton-Bisection method...");
@testset "find_zero --- Newton-Bisection method" begin
    for FT in [Float32, Float64]
        ms = NewtonBisectionMethod{FT}(0,5,2);
        rt = ResidualTolerance{FT}(FT[1e-3], 50);
        st = SolutionTolerance{FT}(1e-3, 50);

        for tol in [rt, st]
            for f in [_r_func, _s_func]
                sol = find_zero(f, ms, tol);
                @test !isnan(sol);
                @test typeof(sol) == FT;
            end
        end

        @show FT;
        @btime find_zero(_r_func, $ms, $rt);
        @btime find_zero(_r_func, $ms, $st);
        @btime find_zero(_s_func, $ms, $rt);
        @btime find_zero(_s_func, $ms, $st);
    end
end
