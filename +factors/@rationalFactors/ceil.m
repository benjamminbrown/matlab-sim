function Y = ceil(X)
% CEIL - Round toward positive infinity
%   This function rounds each element of the input array to the nearest
%   integer greater than or equal to that element.
%
%   Syntax
%     Y = CEIL(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also fix, floor, round
    Y = fix(X);
    % Check for finite positive nonintegers
    isFinitePositiveNoninteger = isfinite(X) & X.Numerator.IsNegative==X.Denominator.IsNegative & X~=Y;
    if any(isFinitePositiveNoninteger,"all")
        % Modify the result where appropriate
        Y(isFinitePositiveNoninteger) = Y(isFinitePositiveNoninteger)+1;
    end
end