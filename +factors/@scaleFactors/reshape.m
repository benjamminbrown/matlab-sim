function A = reshape(A,varargin)
% RESHAPE - Reshape array by rearranging existing elements
%   This function reshapes the input array using the specified size vector
%   or set of dimension sizes.
%
%   Syntax
%     B = RESHAPE(A,sz)
%     B = RESHAPE(A,sz1,...,szN)
%
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
%     sz - Output size
%       positive integer row vector
%     sz1,...,szN - Size of each dimension
%       positive integer scalars | [] (optional)
%
%   See also permute, shiftdim, repmat
    A.Factors = reshape(A.Factors,varargin{:});
    A.Exponents = reshape(A.Exponents,varargin{:});
end