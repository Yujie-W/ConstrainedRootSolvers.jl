###############################################################################
#
# Nelder-Mead method to find peak
#
###############################################################################
function find_peak(
            f::F,
            ms::NelderMeadMethod{FT},
            tol::SolutionToleranceND{FT}
) where {F<:Function, FT<:AbstractFloat}
    # unpack values
    @unpack cen_x, con_x, exp_x, ref_x, x_inis = ms;
    nX = ms.N;
    nS = ms.N + 1;

    # initialize the simplex
    for irow in 1:nS
        ms.simplex[irow] .= x_inis
        if irow < nS
            ms.simplex[irow][irow] = x_inis[irow] / 2;
        end
        ms.simplex[irow][end] = f(ms.simplex[irow])
    end

    # find the optimal simplex
    count_all = 0;
    judges = [false for i in 1:nX];
    while true
        # 1. sort the simplex from high to low
        sort!(ms.simplex, by=x->x[end], rev=true);
        for icol in 1:nX
            judges[icol] = ( abs(ms.simplex[1][icol] - ms.simplex[nS][icol]) <= tol.tol[icol]);
        end
        all(judges) ? break : nothing;

        # 2. calculate the centroid of the N best
        cen_x .= FT(0)
        for irow in 1:nX
            cen_x .+= ms.simplex[irow]
        end
        cen_x ./= nX;

        # 3. reflection of the worst
        ref_x  .= cen_x;
        ref_x .*= 2;
        ref_x .-= ms.simplex[nS];
        ref_y   = f(ref_x);

        if ms.simplex[1][end] >= ref_y > ms.simplex[nX][end]
            ms.simplex[end]     .= ref_x;
            ms.simplex[end][end] = ref_y;

        # 4. expansion of the reflection
        elseif ref_y > ms.simplex[1][end]
            exp_x  .= ref_x;
            exp_x .*= 2;
            exp_x .-= cen_x;
            exp_y   = f(exp_x);

            if exp_y > ref_y
                ms.simplex[end]     .= exp_x;
                ms.simplex[end][end] = exp_y;
            else
                ms.simplex[end]     .= ref_x;
                ms.simplex[end][end] = ref_y;
            end

        # 5. contraction of the worst
        else
            con_x  .= cen_x;
            con_x .+= ms.simplex[nS];
            con_x ./= 2;
            con_y   = f(con_x);

            if con_y > ms.simplex[nS][end]
                ms.simplex[end]     .= con_x;
                ms.simplex[end][end] = con_y;

            # 6. shrink
            else
                for irow in 2:nS
                    ms.simplex[irow]    .+= ms.simplex[1];
                    ms.simplex[irow][end] = f(ms.simplex[irow]);
                end
            end
        end

        # 7. iteration ++
        count_all += 1;

        # 8. determine whether to break
        count_all > tol.n_limit ? break : nothing;
    end

    return view(ms.simplex[1], 1:nX)
end




function find_peak(
            f::F,
            ms::NelderMeadMethod{FT},
            tol::ResidualTolerance{FT}
) where {F<:Function, FT<:AbstractFloat}
    # unpack values
    @unpack cen_x, con_x, exp_x, ref_x, x_inis = ms;
    nX = ms.N;
    nS = ms.N + 1;

    # initialize the simplex
    for irow in 1:nS
        ms.simplex[irow] .= x_inis
        if irow < nS
            ms.simplex[irow][irow] = x_inis[irow] / 2;
        end
        ms.simplex[irow][end] = f(ms.simplex[irow])
    end

    # find the optimal simplex
    count_all = 0;
    while true
        # 1. sort the simplex from high to low
        sort!(ms.simplex, by=x->x[end], rev=true);
        if (ms.simplex[1][end] - ms.simplex[end][end]) < tol.tol
            break
        end

        # 2. calculate the centroid of the N best
        cen_x .= FT(0)
        for irow in 1:nX
            cen_x .+= ms.simplex[irow]
        end
        cen_x ./= nX;

        # 3. reflection of the worst
        ref_x  .= cen_x;
        ref_x .*= 2;
        ref_x .-= ms.simplex[nS];
        ref_y   = f(ref_x);

        if ms.simplex[1][end] >= ref_y > ms.simplex[nX][end]
            ms.simplex[end]     .= ref_x;
            ms.simplex[end][end] = ref_y;

        # 4. expansion of the reflection
        elseif ref_y > ms.simplex[1][end]
            exp_x  .= ref_x;
            exp_x .*= 2;
            exp_x .-= cen_x;
            exp_y   = f(exp_x);

            if exp_y > ref_y
                ms.simplex[end]     .= exp_x;
                ms.simplex[end][end] = exp_y;
            else
                ms.simplex[end]     .= ref_x;
                ms.simplex[end][end] = ref_y;
            end

        # 5. contraction of the worst
        else
            con_x  .= cen_x;
            con_x .+= ms.simplex[nS];
            con_x ./= 2;
            con_y   = f(con_x);

            if con_y > ms.simplex[nS][end]
                ms.simplex[end]     .= con_x;
                ms.simplex[end][end] = con_y;

            # 6. shrink
            else
                for irow in 2:nS
                    ms.simplex[irow]    .+= ms.simplex[1];
                    ms.simplex[irow][end] = f(ms.simplex[irow]);
                end
            end
        end

        # 7. iteration ++
        count_all += 1;

        # 8. determine whether to break
        count_all > tol.n_limit ? break : nothing;
    end

    return view(ms.simplex[1], 1:nX)
end
