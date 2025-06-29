function B = reshape(A,varargin)
    B = A;
    B.IsZero = reshape(A.IsZero,varargin{:});
    B.IsNegative = reshape(A.IsNegative,varargin{:});
    B.Factors = reshape(A.Factors,varargin{:});
    B.Exponents = reshape(A.Exponents,varargin{:});
end