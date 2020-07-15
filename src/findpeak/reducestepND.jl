###############################################################################
#
# Reduce step method to find peak for multiple variables
#
###############################################################################
function find_peak(
            f::F,
            ms::ReduceStepMethodND{FT},
            tol::SolutionToleranceND{FT}
) where {F<:Function, FT<:AbstractFloat}
    # define the initial step
    @unpack x_inis, x_maxs, x_mins, Δ_inis = ms;

    # initial the value
    tar_x = x_inis[:];
    tar_y = f(tar_x);
    new_x = x_inis[:];

    # find the solution
    Nxs = length(tar_x);
    Δxs = Δ_inis[:];
    Δjd = [false for i in 1:Nxs];
    while true
        # total count of updates for all the x values
        count_all = 0;

        for ith in 1:Nxs
            # 1. increase the x by Δx till tar_y is bigger
            count_inc = 0
            while true
                new_x[ith] = tar_x[ith] + Δxs[ith];
                new_x[ith] > x_maxs[ith] ? break : nothing;
                new_y = f(new_x);
                new_y >  tar_y ? (tar_x .= new_x; tar_y=new_y) : break;
                count_inc += 1;
                count_all += 1;
            end
            new_x .= tar_x;

            # 2. decrease the x by Δx till tar_y is bigger
            while count_inc==0
                new_x[ith] = tar_x[ith] - Δxs[ith];
                new_x[ith] < x_mins[ith] ? break : nothing;
                new_y = f(new_x);
                new_y >= tar_y ? (tar_x .= new_x; tar_y=new_y) : break;
                count_all += 1;
            end
            new_x .= tar_x;
        end

        # 3. judge whether to break
        all( Δjd ) ? break : nothing;

        # 4. if no update, then 10% the Δx
        if count_all==0
            for ith in 1:Nxs
                Δxs[ith] > tol.tol[ith] ? (Δxs[ith] /= 10) : (Δjd[ith] = true);
            end
        end
    end

    return tar_x
end
