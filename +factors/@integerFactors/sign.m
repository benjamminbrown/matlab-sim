function X = sign(X)
% SIGN - Sign function (signum function)
%   This function returns a factors.integerFactors array that is zero where
%   the input array is zero, +1 where the input array is positive, and -1
%   where the input array is negative.
%
%   Syntax
%     SIGN(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also abs
    X.Factors(:) = {uint64.empty(1,0)};
    X.Exponents(:) = {uint8.empty(1,0)};
end