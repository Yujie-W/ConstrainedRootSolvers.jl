###############################################################################
#
# Reduce step method to find zero
# As find_zero is meant for 1D optimization, only use the first element
#
###############################################################################
function find_zero(
            f::F,
            ms::ReduceStepMethod{FT},
            tol::AbstractTolerance{FT};
            stepping::Bool = false
) where {F<:Function, FT<:AbstractFloat}
    # create variable to store steps
    if stepping
        steps = Array{FT,1}[];
    end

    # count iterations
    count = 0;

    # define the initial step
    @unpack x_ini, x_max, x_min, Δ_ini = ms;

    # initialize the y
    tar_x = x_ini;
    tar_y = abs( f(tar_x) );

    # record the history
    if stepping
        push!(steps, [tar_x, tar_y]);
    end

    new_x = x_min;
    new_y = abs( f(x_min) );
    new_y < tar_y ? (tar_x=new_x; tar_y=new_y;) : nothing;

    # record the history
    if stepping
        push!(steps, [new_x, new_y]);
    end

    new_x = x_max;
    new_y = abs( f(x_max) );
    new_y < tar_y ? (tar_x=new_x; tar_y=new_y;) : nothing;

    # record the history
    if stepping
        push!(steps, [new_x, new_y]);
    end

    # find the solution
    Δx::FT = Δ_ini;
    while true
        # 1. increase the x by Δx till tar_y is bigger
        count_inc = 0
        while true
            new_x = tar_x + Δx;
            new_x > x_max ? break : nothing;
            new_y = abs( f(new_x) );
            new_y <  tar_y ? (tar_x=new_x; tar_y=new_y;) : break;

            # record the history
            if stepping
                push!(steps, [new_x, new_y]);
            end

            count_inc += 1;
            count += 1;
        end

        # 2. decrease the x by Δx till tar_y is bigger
        count_dec = 0
        while count_inc == 0
            new_x = tar_x - Δx;
            new_x < x_min ? break : nothing;
            new_y = abs( f(new_x) );
            new_y <= tar_y ? (tar_x=new_x; tar_y=new_y;) : break;

            # record the history
            if stepping
                push!(steps, [new_x, new_y]);
            end

            count_dec += 1;
            count += 1;
        end

        # 3. if break
        if if_break(tol, FT(0), Δx, tar_y, count)
            # record the history
            if stepping
                push!(steps, [tar_x, tar_y]);
            end

            break
        end

        # 4. if no update, then 10% the Δx
        if count_inc + count_dec == 0
            Δx /= 10;
        end
    end

    if stepping
        return tar_x, steps
    else
        return tar_x
    end
end
