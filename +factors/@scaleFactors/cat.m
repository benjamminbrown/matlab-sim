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
        varargin    factors.scaleFactors
    end
    obj = varargin{1};
    factorsArgs = cellfun(@(A) A.Factors,varargin(2:nargin-1),"UniformOutput",false);
    obj.Factors = cat(dim,obj.Factors,factorsArgs{:});
    exponentsArgs = cellfun(@(A) A.Exponents,varargin(2:nargin-1),"UniformOutput",false);
    obj.Exponents = cat(dim,obj.Exponents,exponentsArgs{:});
end