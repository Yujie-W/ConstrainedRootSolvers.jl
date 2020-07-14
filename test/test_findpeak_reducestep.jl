# test find_peak function using ReduceStep method
println("Testing find_peak with ReduceStep method...");
@testset "find_peak --- ReduceStep method" begin
    for FT in [Float32, Float64]
        ms = ReduceStepMethod{FT}([0], [5], [1.8], [1]);
        rt = ResidualTolerance{FT}(FT[1e-3], 50);
        lr = [1, 1, 5, 1, 0, 1]
        lf = [_f0, _f1, _f2, _f3, _f4, _f5]

        for i in 1:6
            sol = find_peak(lf[i], ms, rt);
            @test !isnan(sol);
            @test typeof(sol) == FT;
            @test sol ≈ lr[i] atol=0.002;
        end

        @show FT;
        @btime find_peak($_f0, $ms, $rt);
        @btime find_peak($_f1, $ms, $rt);
        @btime find_peak($_f2, $ms, $rt);
        @btime find_peak($_f3, $ms, $rt);
        @btime find_peak($_f4, $ms, $rt);
        @btime find_peak($_f5, $ms, $rt);
    end
end
