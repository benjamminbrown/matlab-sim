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
        A   factors.integerFactors
        B   factors.integerFactors
    end
    [A,B] = utility.implicitArrayExpansion(A,B);
    R = A-B.*factors.integerFactors(fix(A./B));
    if any(B.IsZero,"all")
        R(B.IsZero) = factors.integerFactors.zeros(size(R(B.IsZero)));
    end
end