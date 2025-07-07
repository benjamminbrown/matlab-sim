function obj = NaN(varargin)
    obj = factors.rationalFactors(zeros(varargin{:},"uint8"),zeros(varargin{:},"uint8"));
end