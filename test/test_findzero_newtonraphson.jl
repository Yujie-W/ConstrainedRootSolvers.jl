# test find_zero function using NewtonRaphson method
println("\nTesting find_zero with NewtonRaphson method...");
@testset "find_zero --- NewtonRaphson method" begin
    for FT in [Float32, Float64]
        ms = NewtonRaphsonMethod{FT}(2);
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
