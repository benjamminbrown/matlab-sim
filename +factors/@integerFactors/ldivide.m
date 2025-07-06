function C = ldivide(B,A)
% LDIVIDE - Left array division
%   This function divides each element of the right array by the
%   corresponding element of the left array. For factors.integerFactors
%   arrays, this overloaded function is equivalent to constructing an
%   appropriate factors.rationalFactors array.
%
%   Syntax
%     x = B.\A
%     x = LDIVIDE(B,A)
%
%   Input Arguments
%     B - Left operand
%       scalar | vector | matrix | multidimensional array
%     A - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also rdivide, mldivide, mrdivide

    % Pass operands to the rdivide method
    C = rdivide(A,B);
end