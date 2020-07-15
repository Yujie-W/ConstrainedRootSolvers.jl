# test find_peak function using NelderMeadMethod method
println("\nTesting find_peak with NelderMeadMethod method...");
@testset "find_peak --- NelderMeadMethod method" begin
    for FT in [Float32]#, Float64]
        ms = NelderMeadMethod{FT}(N=2, x_inis=FT[rand(FT)+1, rand(FT)+2, 0]);
        rt = ResidualTolerance{FT}(1e-5, 50);
        st = SolutionToleranceND{FT}(FT[1e-3, 1e-3], 50);

        for result in [ find_peak(_surf_func, ms, rt),
                        find_peak(_surf_func, ms, st) ]
            @test all( .!isnan.(result) );
            @test eltype(result) == FT;
            @test result[1] ≈ 2 atol=0.01;
            @test result[2] ≈ 3 atol=0.01;
        end

        if benchmarking
            @btime find_peak($_surf_func, $ms, $rt);
            @btime find_peak($_surf_func, $ms, $st);
        end
    end
end
