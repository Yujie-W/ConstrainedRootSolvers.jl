###############################################################################
#
# Find the peak using Bisection method
# slope = 0 does not work for segmented curves
#
###############################################################################
"""
    next_xy!(f::F, xy::Array{FT,2})

Determine the next points to, given
- `f` Function to find peak
- `xy` Array of x and y
"""
function next_xy!(
            f::F,
            xy::Array{FT,2}
            ) where {F<:Function, FT<:AbstractFloat}
    x1,x2,x3,y1,y2,y3 = xy;
    # if the curve if flat, do nothing
    if y1==y2==y3
        return false

    # cases to update only the first part
    elseif (y1==y2>y3) || (y1>y2)
        xn      = (x1+x2) / 2;
        yn      = f(xn);
        xy[3,1] = x2;
        xy[3,2] = y2;
        xy[2,1] = xn;
        xy[2,2] = yn;

        return true

    # cases to update only the second part
    elseif y1<=y2<y3
        xn      = (x2+x3) / 2;
        yn      = f(xn);
        xy[1,1] = x2;
        xy[1,2] = y2;
        xy[2,1] = xn;
        xy[2,2] = yn;

        return true

    # cases to update both parts, y1<y2>=y3
    else
        xn = (x1+x2) / 2;
        yn = f(xn);
        if yn >= y2
            xy[3,1] = x2;
            xy[3,2] = y2;
            xy[2,1] = xn;
            xy[2,2] = yn;
        else
            xy[1,1] = xn;
            xy[1,2] = yn;

            xn = (x2+x3) / 2;
            yn = f(xn);
            if yn > y2
                xy[1,1] = x2;
                xy[1,2] = y2;
                xy[2,1] = xn;
                xy[2,2] = yn;
            else
                xy[3,1] = xn;
                xy[3,2] = yn;
            end
        end

        return true

    end
end




"""
    find_peak(f::F, ms::AbstractRootSolvingMethod{FT}, tol::AbstractTolerance{FT}) where {F<:Function, FT<:AbstractFloat}

Find the solution, given
- `f` A function to solve
- `ms` [`BisectionMethod`](@ref) type method struct
- `tol` [`AbstractTolerance`](@ref) type tolerance struct

Note that to compute the lowest value, use -f to make it a peak.

## Possible combinations

| Method Type                | Tolerance type              | Pass Test |
|:--------------------------:|:---------------------------:|:---------:|
| [`BisectionMethod`](@ref)  | [`ResidualTolerance`](@ref) | 2 allocs  |
| [`ReduceStepMethod`](@ref) | [`ResidualTolerance`](@ref) | Yes       |
| [`ReduceStepMethod`](@ref) | [`StepTolerance`](@ref)     | Yes       |

"""
function find_peak(
            f::F,
            ms::BisectionMethod{FT},
            tol::ResidualTolerance{FT}
) where {F<:Function, FT<:AbstractFloat}
    # count for iterations
    count::Int = 0

    # create matrix to store data
    xy      = ones(FT, (3,2));
    xy[1,1] = ms.x_min;
    xy[2,1] = (ms.x_min + ms.x_max) / 2;
    xy[3,1] = ms.x_max;
    xy[1,2] = f(xy[1,1]);
    xy[2,2] = f(xy[2,1]);
    xy[3,2] = f(xy[3,1]);

    # update the xy depending on the curve shape
    while next_xy!(f, xy)
        # count ++
        count += 1;

        # judge whether to break
        if if_break_uni(tol, xy[1,1], xy[3,1], FT(1), count)
            break
        end
    end

    # get solution
    _maxy,_indy = findmax(xy[:,2]);

    return xy[_indy,1]
end
