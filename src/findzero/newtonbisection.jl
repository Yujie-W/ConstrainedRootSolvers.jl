###############################################################################
#
# Newton Raphson combined with Bi-section method for find first zero
#
###############################################################################
function find_zero(
            f::F,
            ms::NewtonBisectionMethod{FT},
            tol::AbstractTolerance{FT}
) where {F<:Function, FT<:AbstractFloat}
    # count for iterations
    count::Int = 0

    # calculate the values for x_min and x_max first
    x_dif = tol.tol[1];
    x_min = ms.x_min;
    x_max = ms.x_max;
    y_min = f(x_min);
    y_max = f(x_max);

    # if y_min and y_max are on the same side
    if y_min * y_max > 0
        if abs(y_max) < abs(y_min)
            return x_max
        else
            return x_min
        end

    # if y_min is 0
    elseif y_min==0
        return x_min

    # if y_min and y_max are on different side, or one of them is 0
    else
        x_ntr = ms.x_ini;
        while true
            y_ntr = f(x_ntr);

            # if difference is lower than the tolerance
            if if_break_uni(tol, x_min, x_max, y_ntr, count)
                break
            end

            # if y_ntr is on the same side with one of them
            if y_ntr * y_min > 0
                x_min = x_ntr;
                y_min = y_ntr;
            elseif y_ntr * y_max > 0
                x_max = x_ntr;
                y_max = y_ntr;

            # if y_ntr = 0 and one of y_min and y_max is 0
            elseif (y_min==0) && (y_ntr==0)
                x_min = x_ntr;
                y_min = y_ntr;
            elseif (y_max==0) && (y_ntr==0)
                x_max = x_ntr;
                y_max = y_ntr;

            # else set x_max to x_ntr (takes the fisrt one)
            else
                x_max = x_ntr;
                y_max = y_ntr;
            end

            # update x_ntr using Newton Raphson
            x_dx   = x_ntr + x_dif * 10;
            y_dx   = f(x_dx);
            slope  = (y_dx - y_ntr) / (x_dx - x_ntr);
            x_ntr -= y_ntr / slope;

            # set x_ntr in the correct range
            if (x_ntr>=x_max) || (x_ntr<=x_min) || isnan(x_ntr)
                x_ntr = (x_min + x_max) / 2;
            end

            # count ++
            count += 1;
        end

        return x_ntr
    end
end
