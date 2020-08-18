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
    @unpack x_inis, x_maxs, x_mins, x_targ, x_temp, Δ_inis, Δ_oper, Δjd = ms;

    # initial the value
    tar_y = f(x_targ);

    # find the solution
    Nxs = length(x_targ);
    while true
        # total count of updates for all the x values
        count_all = 0;

        for ith in 1:Nxs
            # 1. increase the x by Δx till tar_y is bigger
            count_inc = 0
            while true
                x_temp[ith] = x_targ[ith] + Δ_oper[ith];
                x_temp[ith] > x_maxs[ith] ? break : nothing;
                new_y = f(x_temp);
                new_y >  tar_y ? (x_targ .= x_temp; tar_y=new_y) : break;
                count_inc += 1;
                count_all += 1;
            end
            x_temp .= x_targ;

            # 2. decrease the x by Δx till tar_y is bigger
            while count_inc==0
                x_temp[ith] = x_targ[ith] - Δ_oper[ith];
                x_temp[ith] < x_mins[ith] ? break : nothing;
                new_y = f(x_temp);
                new_y >= tar_y ? (x_targ .= x_temp; tar_y=new_y) : break;
                count_all += 1;
            end
            x_temp .= x_targ;
        end

        # 3. judge whether to break
        all( Δjd ) ? break : nothing;

        # 4. if no update, then 10% the Δx
        if count_all==0
            for ith in 1:Nxs
                Δ_oper[ith] > tol.tol[ith] ?
                              (Δ_oper[ith] /= 10) : (Δjd[ith] = true);
            end
        end
    end

    return x_targ
end
