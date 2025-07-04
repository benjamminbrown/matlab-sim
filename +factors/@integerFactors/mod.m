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
        A   factors.integerFactors
        M   factors.integerFactors
    end
    [A,M] = utility.implicitArrayExpansion(A,M);
    B = A-M.*factors.integerFactors(floor(A./M));
    if any(M.IsZero,"all")
        B(M.IsZero) = A(M.IsZero);
    end
end