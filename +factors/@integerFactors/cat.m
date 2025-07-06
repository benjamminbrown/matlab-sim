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
        varargin    factors.integerFactors
    end
    % Initialize the output array
    obj = varargin{1};
    % Concatenate each of the properties
    isZeroArgs = cellfun(@(A) A.IsZero,varargin(2:nargin-1),"UniformOutput",false);
    obj.IsZero = cat(dim,obj.IsZero,isZeroArgs{:});
    isNegativeArgs = cellfun(@(A) A.IsNegative,varargin(2:nargin-1),"UniformOutput",false);
    obj.IsNegative = cat(dim,obj.IsNegative,isNegativeArgs{:});
    factorsArgs = cellfun(@(A) A.Factors,varargin(2:nargin-1),"UniformOutput",false);
    obj.Factors = cat(dim,obj.Factors,factorsArgs{:});
    exponentsArgs = cellfun(@(A) A.Exponents,varargin(2:nargin-1),"UniformOutput",false);
    obj.Exponents = cat(dim,obj.Exponents,exponentsArgs{:});
end