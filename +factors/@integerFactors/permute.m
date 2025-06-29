function B = permute(A,dimorder)
    B = A;
    B.IsZero = permute(A.IsZero,dimorder);
    B.IsNegative = permute(A.IsNegative,dimorder);
    B.Factors = permute(A.Factors,dimorder);
    B.Exponents = permute(B.Exponents,dimorder);
end