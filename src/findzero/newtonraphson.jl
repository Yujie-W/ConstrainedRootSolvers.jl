###############################################################################
#
# Newton Raphson method for find first zero
#
###############################################################################
function find_zero(
            f::F,
            ms::NewtonRaphsonMethod{FT},
            tol::AbstractTolerance{FT}
) where {F<:Function, FT<:AbstractFloat}
    # count for iterations
    count::Int = 0

    # calculate the values for x_min and x_max first
    x_dif = tol.tol;

    # find the solution
    x_lst = FT(Inf);
    x_ntr = ms.x_ini;
    while true
        y_ntr = f(x_ntr);

        # if difference is lower than the tolerance
        if if_break_uni(tol, x_lst, x_ntr, y_ntr, count)
            break
        end

        # update x_ntr using Newton Raphson
        x_dx   = x_ntr + x_dif;
        y_dx   = f(x_dx);
        slope  = (y_dx - y_ntr) / (x_dx - x_ntr);
        x_lst  = x_ntr;
        x_ntr -= y_ntr / slope;
        x_dif  = tol.tol / abs(slope);

        # count ++
        count += 1;
    end

    return x_ntr
end
