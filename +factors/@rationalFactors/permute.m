function A = permute(A,dimorder)
% PERMUTE - Permute array dimensions
%   This function rearranges the dimensions of an array in the specified
%   order.
%
%   Syntax
%     B = PERMUTE(A,dimorder)
%
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
%     dimorder - Dimension order
%       positive integer row vector
%
%   See also ipermute, reshape, shiftdim, transpose
    A.Numerator = permute(A.Numerator,dimorder);
    A.Denominator = permute(A.Denominator,dimorder);
end