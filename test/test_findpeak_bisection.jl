# test find_peak function using Bisection method
println("\nTesting find_peak with Bisection method...");
@testset "find_peak --- Bisection method" begin
    for FT in [Float32, Float64]
        ms = BisectionMethod{FT}(0, 5);
        st = SolutionTolerance{FT}(1e-3, 50);
        lr = [1, 1, 5, 1, 0, 1]
        lf = [_f0, _f1, _f2, _f3, _f4, _f5]

        for i in 1:6
            sol = find_peak(lf[i], ms, st);
            @test !isnan(sol);
            @test typeof(sol) == FT;
            @test sol ≈ lr[i] atol=0.01;
        end
    end
end
