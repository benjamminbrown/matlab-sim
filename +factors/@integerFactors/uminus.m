function A = uminus(A)
% UMINUS - Unary minus
%   This function returns the input array with its elements negated.
%
%   Syntax
%     C = -A
%     C = UMINUS(A)
%
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also uplus, minus
    A.IsNegative = ~A.IsNegative;
end