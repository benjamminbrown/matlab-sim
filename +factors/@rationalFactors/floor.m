function Y = floor(X)
% FLOOR - Round toward negative infinity
%   This function rounds each element of the input array to the nearest
%   integer less than or equal to that element.
%
%   Syntax
%     Y = FLOOR(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also ceil, fix, round
    Y = fix(X);
    % Check for finite negative nonintegers
    isFiniteNegativeNoninteger = isfinite(X) & X.Numerator.IsNegative~=X.Denominator.IsNegative & X~=Y;
    if any(isFiniteNegativeNoninteger,"all")
        % Modify the result where appropriate
        Y(isFiniteNegativeNoninteger) = Y(isFiniteNegativeNoninteger)-1;
    end
end