function A = transpose(A)
% TRANSPOSE - Transpose vector or matrix
%   This function returns the nonconjugate transpose of the input array by
%   interchanging the row and column index for each element.
%
%   Syntax
%     B = A.'
%     B = TRANSPOSE(A)
%
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix
%
%   See also ctranspose, permute, conj, pagetranspose
    A.Factors = transpose(A.Factors);
    A.Exponents = transpose(A.Exponents);
end