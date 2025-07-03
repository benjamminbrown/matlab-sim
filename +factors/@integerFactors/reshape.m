function A = reshape(A,varargin)
    A.IsZero = reshape(A.IsZero,varargin{:});
    A.IsNegative = reshape(A.IsNegative,varargin{:});
    A.Factors = reshape(A.Factors,varargin{:});
    A.Exponents = reshape(A.Exponents,varargin{:});
end