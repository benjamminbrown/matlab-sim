function obj = cat(dim,varargin)
    arguments
        dim
    end
    arguments (Repeating)
        varargin    factors.integerFactors
    end
    obj = varargin{1};
    isZeroArgs = cellfun(@(A) A.IsZero,varargin(2:nargin-1),"UniformOutput",false);
    obj.IsZero = cat(dim,obj.IsZero,isZeroArgs{:});
    isNegativeArgs = cellfun(@(A) A.IsNegative,varargin(2:nargin-1),"UniformOutput",false);
    obj.IsNegative = cat(dim,obj.IsNegative,isNegativeArgs{:});
    factorsArgs = cellfun(@(A) A.Factors,varargin(2:nargin-1),"UniformOutput",false);
    obj.Factors = cat(dim,obj.Factors,factorsArgs{:});
    exponentsArgs = cellfun(@(A) A.Exponents,varargin(2:nargin-1),"UniformOutput",false);
    obj.Exponents = cat(dim,obj.Exponents,exponentsArgs{:});
end