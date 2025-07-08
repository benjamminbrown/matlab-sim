function R = rem(A,B)
% REM - Remainder after division
%   This function returns the remainder after division of a specified
%   dividend by a specified divisor.
%
%   Syntax
%     R = REM(A,B)
%
%   Input Arguments
%     A - Dividend
%       scalar | vector | matrix | multidimensional array
%     B - Divisor
%       scalar | vector | matrix | multidimensional array
%
%   See also mod
    arguments
        A   factors.rationalFactors
        B   factors.rationalFactors
    end
    [A,B] = utility.implicitArrayExpansion(A,B);
    R = factors.rationalFactors.NaN(size(A));
    isValidRem = isfinite(A) & ~B.Numerator.IsZero;
    if any(isValidRem,"all")
        R(isValidRem) = factors.rationalFactors(rem(A.Numerator(isValidRem).*B.Denominator(isValidRem),B.Numerator(isValidRem).*A.Denominator(isValidRem)), ...
                                                A.Denominator(isValidRem).*B.Denominator(isValidRem));
    end
end