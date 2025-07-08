function varargout = size(obj,varargin)
% SIZE - Array size
%   This function returns a row vector whose elements are the lengths of
%   the corresponding dimensions of the input array.
%
%   Syntax
%     sz = SIZE(A)
%     szdim = SIZE(A,dim)
%     szdim = SIZE(A,dim1,dim2,...,dimN)
%     [sz1,...,szN] = SIZE(___)
%
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
%     dim - Queried dimensions
%       positive integer scalar | positive integer vector | empty array
%     dim1,dim2,...dimN - List of queried dimension
%       positive integer scalars
%
%   Output Arguments
%     sz - Array size
%       nonnegative integer row vector
%     szdim - Dimension lengths
%       nonnegative integer scalar | nonnegative integer vector |
%       1-by-0 empty array
%     sz1,...,szN - Dimension lengths listed separately
%       nonnegative integer scalars
%
%   See also length, ndims, numel, height, width
    [varargout{1:nargout}] = size(obj.Numerator,varargin{:});
end