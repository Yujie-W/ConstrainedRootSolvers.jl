# test find_peak function using ReduceStepND method
println("\nTesting find_peak with ReduceStepND method...");
@testset "find_peak --- ReduceStepND method" begin
    for FT in [Float32, Float64]
        ms = ReduceStepMethodND{FT}(FT[0,0], FT[5,5], [1+rand(FT), 2+rand(FT)], FT[1,1]);
        st = SolutionToleranceND{FT}(FT[1e-3, 1e-3], 50);

        sol = find_peak(_surf_func, ms, st);
        @test all( .!isnan.(sol) );
        @test eltype(sol) == FT;
        @test sol[1] ≈ 2 atol=0.01;
        @test sol[2] ≈ 3 atol=0.01;
    end
end
