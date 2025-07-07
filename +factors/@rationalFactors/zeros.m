function obj = zeros(varargin)
    obj = factors.rationalFactors(zeros(varargin{:},"uint8"));
end