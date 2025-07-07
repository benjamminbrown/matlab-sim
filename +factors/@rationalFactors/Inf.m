function obj = Inf(varargin)
% INF - Create array of all Inf values
%   This function creates a factors.rationalFactors array of all positive
%   infinite values.
%
%   Syntax
%     X = factors.rationalFactors.Inf
%     X = factors.rationalFactors.Inf(n)
%     X = factors.rationalFactors.Inf(sz1,...,szN)
%     X = factors.rationalFactors.Inf(sz)
%
%   Input Arguments
%     n - Dimension of square matrix
%       nonnegative integer scalar
%     sz1,...,szN - Dimensions of array
%       nonnegative integer scalars
%     sz - Vector of dimensions of array
%       nonnegative integer row vector
%
%   See also NaN, isinf, isnan, isfinite
    obj = factors.rationalFactors(ones(varargin{:},"uint8"),zeros(varargin{:},"uint8"));
end