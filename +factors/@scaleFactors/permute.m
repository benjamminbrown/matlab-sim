function B = permute(A,dimorder)
    B = A;
    B.Factors = permute(A.Factors,dimorder);
    B.Exponents = permute(B.Exponents,dimorder);
end