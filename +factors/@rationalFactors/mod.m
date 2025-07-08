function B = mod(A,M)
% MOD - Remainder after division (modulo operation)
%   This function returns the remainder after division of a specified
%   dividend by a specified divisor.
%
%   Syntax
%     B = MOD(A,M)
%
%   Input Arguments
%     A - Dividend
%       scalar | vector | matrix | multidimensional array
%     M - Divisor
%       scalar | vector | matrix | multidimensional array
%
%   See also rem
    arguments
        A   factors.rationalFactors
        M   factors.rationalFactors
    end
    [A,M] = utility.implicitArrayExpansion(A,M);
    B = factors.rationalFactors.NaN(size(A));
    isZeroM = M.Numerator.IsZero & ~M.Denominator.IsZero;
    if any(isZeroM,"all")
        B(isZeroM) = A(isZeroM);
    end
    isValidMod = isfinite(A) & ~isZeroM;
    if any(isValidMod,"all")
        B(isValidMod) = factors.rationalFactors(mod(A.Numerator(isValidMod).*M.Denominator(isValidMod),M.Numerator(isValidMod).*A.Denominator(isValidMod)), ...
                                                A.Denominator(isValidMod).*M.Denominator(isValidMod));
    end
end