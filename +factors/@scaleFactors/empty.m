function obj = empty(varargin)
% EMPTY - Create empty factors.scaleFactors array
%   This function creates an empty factors.scaleFactors array.
% 
%   Syntax
%     X = factors.scaleFactors.empty
%     X = factors.scaleFactors.empty(0)
%     X = factors.scaleFactors.empty(sz1,...,szN)
%     X = factors.scaleFactors.empty(sz)
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
    obj = factors.scaleFactors(uint8.empty(varargin{:}));
end