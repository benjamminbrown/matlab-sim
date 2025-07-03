function A = permute(A,dimorder)
    A.IsZero = permute(A.IsZero,dimorder);
    A.IsNegative = permute(A.IsNegative,dimorder);
    A.Factors = permute(A.Factors,dimorder);
    A.Exponents = permute(A.Exponents,dimorder);
end