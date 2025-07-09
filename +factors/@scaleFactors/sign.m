function Y = sign(X)
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
    Y = factors.scaleFactors.ones(size(X));
end