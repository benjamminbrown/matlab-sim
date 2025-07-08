function obj = ones(varargin)
% ONES - Create factors.rationalFactors array of all ones
%   This function creates a factors.rationalFactors array of all ones.
% 
%   Syntax
%     X = ONES
%     X = ONES(n)
%     X = ONES(sz1,...,szN)
%     X = ONES(sz)
%
%   Input Arguments
%     n - Dimension of square matrix
%       nonnegative integer scalar
%     sz1,...,szN - Dimensions of array
%       nonnegative integer scalars
%     sz - Vector of dimensions of array
%       nonnegative integer row vector
% 
%   See also zeros, size
    obj = factors.rationalFactors(ones(varargin{:},"uint8"));
end