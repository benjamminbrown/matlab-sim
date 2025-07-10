function C = power(A,B)
% POWER - Element-wise power
%   This function raises each element of the first operand to the
%   corresponding power in the second operand.
%
%   Syntax
%     C = A.^B
%     C = POWER(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also mpower
    arguments
        A   factors.rationalFactors
        B   factors.integerFactors
    end
    % Implicitly expand singleton dimensions of input arrays
    [A,B] = utility.implicitArrayExpansion(A,B);
    % Raise numerator and denominator to absolute value of power
    absB = abs(B);
    C = factors.rationalFactors(A.Numerator.^absB,A.Denominator.^absB);
    if any(B.IsNegative,"all")
        % Swap numerator and denominator where power is negative
        [C.Numerator(B.IsNegative),C.Denominator(B.IsNegative)] = deal(C.Denominator(B.IsNegative),C.Numerator(B.IsNegative));
    end
end