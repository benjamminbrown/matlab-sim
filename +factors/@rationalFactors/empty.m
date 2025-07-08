function obj = empty(varargin)
% EMPTY - Create empty factors.rationalFactors array
%   This function creates an empty factors.rationalFactors array.
% 
%   Syntax
%     X = factors.rationalFactors.empty
%     X = factors.rationalFactors.empty(0)
%     X = factors.rationalFactors.empty(sz1,...,szN)
%     X = factors.rationalFactors.empty(sz)
% 
%   Input Arguments
%     0 - Dimension of empty square matrix
%       zero scalar
%     sz1,...,szN - Dimensions of array
%       nonnegative integer scalars
%     sz - Vector of dimensions of array
%       nonnegative integer row vector
% 
%   See also isempty, size, length
    obj = factors.rationalFactors(uint8.empty(varargin{:}));
end