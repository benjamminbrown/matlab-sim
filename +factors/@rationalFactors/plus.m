function C = plus(A,B)
% PLUS - Add numbers
%   This function adds the corresponding elements of the input arrays.
%
%   Syntax
%     C = A + B
%     C = PLUS(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also minus, uplus
    arguments
        A   factors.rationalFactors
        B   factors.rationalFactors
    end
    C = factors.rationalFactors(A.Numerator.*B.Denominator+B.Numerator.*A.Denominator, ...
                                A.Denominator.*B.Denominator);
end