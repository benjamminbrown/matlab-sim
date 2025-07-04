function A = uminus(A)
% UMINUS - Unary minus
%   This function negates the elements of A and stores the result in C.
%
%   Syntax
%     C = +A
%     C = UMINUS(A)
%
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also uplus, minus
    A.IsNegative = ~A.IsNegative;
end