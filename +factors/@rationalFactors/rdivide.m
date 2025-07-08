function C = rdivide(A,B)
% RDIVIDE - Right array division
%   This function divides each element of the left array by the
%   corresponding element of the right array.
%
%   Syntax
%     x = A./B
%     x = RDIVIDE(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also ldivide, mrdivide, mldivide

    % Pass operands to the factors.rationalFactors constructor
    C = factors.rationalFactors(A,B);
end