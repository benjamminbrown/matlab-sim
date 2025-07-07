function obj = Inf(varargin)
    obj = factors.rationalFactors(ones(varargin{:},"uint8"),zeros(varargin{:},"uint8"));
end