function A = ctranspose(A)
% CTRANSPOSE - Transpose vector or matrix
%   This function returns the complex conjugate transpose of the input
%   array.
%
%   Syntax
%     B = A'
%     B = CTRANSPOSE(A)
%
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix
%
%   See also transpose, permute, conj, pagectranspose
    A = transpose(A);
end