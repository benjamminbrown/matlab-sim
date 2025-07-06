function C = ldivide(A,B)
% LDIVIDE - Left array division
%   This function divides each element of the right array by the
%   corresponding element of the left array. For factors.integerFactors
%   arrays, this overloaded function is equivalent to constructing an
%   appropriate factors.rationalFactors array.
%
%   Syntax
%     x = A./B
%     x = LDIVIDE(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also rdivide, mldivide, mrdivide

    % Pass operands to the factors.rationalFactors constructor
    C = factors.rationalFactors(B,A);
end