function obj = empty(varargin)
% EMPTY - Create empty factors.integerFactors array
%   This function creates an empty factors.integerFactors array.
% 
%   Syntax
%     X = factors.integerFactors.empty
%     X = factors.integerFactors.empty(0)
%     X = factors.integerFactors.empty(sz1,...,szN)
%     X = factors.integerFactors.empty(sz)
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
    obj = factors.integerFactors(uint8.empty(varargin{:}));
end