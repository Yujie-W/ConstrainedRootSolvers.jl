###############################################################################
#
# Bi-section method for find first zero
#
###############################################################################
"""
    find_zero(f::F, ms::AbstractRootSolvingMethod{FT}, tol::AbstractTolerance{FT}) where {F<:Function, FT<:AbstractFloat}

Find the solution, given
- `f` Function to solve
- `ms` [`AbstractRootSolvingMethod`](@ref) type method struct
- `tol` [`AbstractTolerance`](@ref) type tolerance struct

## Possible combinations

| Method Type                     | Tolerance Type              | Pass Test |
|:-------------------------------:|:---------------------------:|:---------:|
| [`BisectionMethod`](@ref)       | [`ResidualTolerance`](@ref) | Yes       |
| [`BisectionMethod`](@ref)       | [`SolutionTolerance`](@ref) | Yes       |
| [`NewtonBisectionMethod`](@ref) | [`ResidualTolerance`](@ref) | Yes       |
| [`NewtonBisectionMethod`](@ref) | [`SolutionTolerance`](@ref) | Yes       |
| [`NewtonRaphsonMethod`](@ref)   | [`ResidualTolerance`](@ref) | Yes       |
| [`NewtonRaphsonMethod`](@ref)   | [`SolutionTolerance`](@ref) | Yes       |
| [`ReduceStepMethod`](@ref)      | [`ResidualTolerance`](@ref) | Yes       |
| [`ReduceStepMethod`](@ref)      | [`SolutionTolerance`](@ref) | Yes       |

"""
function find_zero(
            f::F,
            ms::BisectionMethod{FT},
            tol::AbstractTolerance{FT}
) where {F<:Function, FT<:AbstractFloat}
    # count for iterations
    count::Int = 0

    # calculate the values for x_min and x_max first
    x_min = ms.x_min;
    x_max = ms.x_max;
    x_mid = x_min   ;
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
        while true
            x_mid = (x_min + x_max) / 2;
            y_mid = f(x_mid);

            # if difference is lower than the tolerance
            if if_break_uni(tol, x_min, x_max, y_mid, count)
                break
            end

            # if y_mid is on the same side with one of them
            if y_mid * y_min > 0
                x_min = x_mid;
                y_min = y_mid;
            elseif y_mid * y_max > 0
                x_max = x_mid;
                y_max = y_mid;

            # if y_mid = 0 and one of y_min and y_max is 0
            elseif (y_min==0) && (y_mid==0)
                x_min = x_mid;
                y_min = y_mid;
            elseif (y_max==0) && (y_mid==0)
                x_max = x_mid;
                y_max = y_mid;

            # else set x_max to x_mid (takes the fisrt one)
            else
                x_max = x_mid;
                y_max = y_mid;
            end

            # count ++
            count += 1
        end

        return x_mid
    end
end
