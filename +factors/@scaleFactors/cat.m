function obj = cat(dim,varargin)
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