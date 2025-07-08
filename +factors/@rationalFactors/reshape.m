function A = reshape(A,varargin)
    A.Numerator = reshape(A.Numerator,varargin{:});
    A.Denominator = reshape(A.Denominator,varargin{:});
end