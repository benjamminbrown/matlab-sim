function obj = zeros(varargin)
% ZEROS - Create factors.rationalFactors array of all zeros
%   This function creates a factors.rationalFactors array of all zeros.
% 
%   Syntax
%     X = ZEROS
%     X = ZEROS(n)
%     X = ZEROS(sz1,...,szN)
%     X = ZEROS(sz)
%
%   Input Arguments
%     n - Dimension of square matrix
%       nonnegative integer scalar
%     sz1,...,szN - Dimensions of array
%       nonnegative integer scalars
%     sz - Vector of dimensions of array
%       nonnegative integer row vector
% 
%   See also ones, size
    obj = factors.rationalFactors(zeros(varargin{:},"uint8"));
end