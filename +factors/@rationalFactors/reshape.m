function B = reshape(A,varargin)
    B = A;
    B.Numerator = reshape(A.Numerator,varargin{:});
    B.Denominator = reshape(A.Denominator,varargin{:});
end