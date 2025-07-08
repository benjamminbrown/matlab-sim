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
    X.Numerator = sign(X.Numerator);
    isInfinite = isinf(X);
    if any(isInfinite,"all")
        X.Denominator(isInfinite) = factors.integerFactors((-1).^X.Denominator.IsNegative(isInfinite));
    end
    isNoninfinite = ~isInfinite;
    if any(isNoninfinite,"all")
        X.Denominator(isNoninfinite) = sign(X.Denominator(isNoninfinite));
    end
end