# test find_peak function using ReduceStep method
println("\nTesting find_peak with ReduceStep method...");
@testset "find_peak --- ReduceStep method" begin
    for FT in [Float32, Float64]
        ms = ReduceStepMethod{FT}(0, 5, 1+rand(FT), 1);
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
