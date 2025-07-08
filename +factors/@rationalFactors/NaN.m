function obj = NaN(varargin)
% NAN - Create array of all NaN values
%   This function creates a factors.rationalFactors array of all "not a
%   number" values.
%
%   Syntax
%     X = factors.rationalFactors.NaN
%     X = factors.rationalFactors.NaN(n)
%     X = factors.rationalFactors.NaN(sz1,...,szN)
%     X = factors.rationalFactors.NaN(sz)
%
%   Input Arguments
%     n - Dimension of square matrix
%       nonnegative integer scalar
%     sz1,...,szN - Dimensions of array
%       nonnegative integer scalars
%     sz - Vector of dimensions of array
%       nonnegative integer row vector
%
%   See also Inf, isnan, isinf, isfinite
    obj = factors.rationalFactors(zeros(varargin{:},"uint8"),zeros(varargin{:},"uint8"));
end