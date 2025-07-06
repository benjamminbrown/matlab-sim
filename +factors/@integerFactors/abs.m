function X = abs(X)
% ABS - Absolute value
%   This function returns the absolute value of each element in the input
%   array.
%
%   Syntax
%     Y = ABS(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also sign
    X.IsNegative(:) = false;
end