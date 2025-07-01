function B = reshape(A,varargin)
    B = A;
    B.Factors = reshape(A.Factors,varargin{:});
    B.Exponents = reshape(A.Exponents,varargin{:});
end