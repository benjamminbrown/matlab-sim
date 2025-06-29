function obj = cat(dim,varargin)
    arguments
        dim
    end
    arguments (Repeating)
        varargin    factors.rationalFactors
    end
    obj = varargin{1};
    numeratorArgs = cellfun(@(A) A.Numerator,varargin(2:nargin-1),"UniformOutput",false);
    obj.Numerator = cat(dim,obj.Numerator,numeratorArgs{:});
    denominatorArgs = cellfun(@(A) A.Denominator,varargin(2:nargin-1),"UniformOutput",false);
    obj.Denominator = cat(dim,obj.Denominator,denominatorArgs{:});
end