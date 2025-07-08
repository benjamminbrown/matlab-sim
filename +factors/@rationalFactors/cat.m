function obj = cat(dim,varargin)
% CAT - Concatenate arrays
%   This function concatenates arrays with compatible sizes sequentially
%   along the specified dimension.
%
%   Syntax
%     C = CAT(dim,A1,A2,...,AN)
%
%   Input Arguments
%     dim - Dimension to operate along
%       positive integer scalar
%     A1,A2,...,AN - List of input arrays
%       scalars | vectors | matrices | multidimensional arrays
%
%   See also vertcat, horzcat
    arguments
        dim
    end
    arguments (Repeating)
        varargin    factors.rationalFactors
    end
    % Initialize the output array
    obj = varargin{1};
    % Concatenate each of the properties
    numeratorArgs = cellfun(@(A) A.Numerator,varargin(2:nargin-1),"UniformOutput",false);
    obj.Numerator = cat(dim,obj.Numerator,numeratorArgs{:});
    denominatorArgs = cellfun(@(A) A.Denominator,varargin(2:nargin-1),"UniformOutput",false);
    obj.Denominator = cat(dim,obj.Denominator,denominatorArgs{:});
end