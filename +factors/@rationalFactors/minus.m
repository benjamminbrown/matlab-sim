function C = minus(A,B)
% MINUS - Subtraction
%   This function subtracts the corresponding elements of the right array
%   from those of the left array.
%
%   Syntax
%     C = A - B
%     C = MINUS(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also plus, uminus
    C = A+-B;
end