function C = times(A,B)
% TIMES - Multiplication
%   This function multiplies the corresponding elements of the input
%   arrays.
%
%   Syntax
%     C = A.*B
%     C = TIMES(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also mtimes
    arguments
        A   factors.rationalFactors
        B   factors.rationalFactors
    end
    C = factors.rationalFactors(A.Numerator.*B.Numerator, ...
                                A.Denominator.*B.Denominator);
end