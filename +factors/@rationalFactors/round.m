function X = round(X)
% ROUND - Round to nearest integer
%   This function rounds each element of the input array to the nearest
%   integer.
%
%   Syntax
%     Y = ROUND(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also ceil, fix, floor
    shiftedX = X+factors.rationalFactors(1,2);
    X = shiftedX-mod(shiftedX,1);
end