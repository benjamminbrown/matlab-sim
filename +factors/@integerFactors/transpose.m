function B = transpose(A)
    B = A;
    B.IsZero = transpose(A.IsZero);
    B.IsNegative = transpose(A.IsNegative);
    B.Factors = transpose(A.Factors);
    B.Exponents = transpose(A.Exponents);
end