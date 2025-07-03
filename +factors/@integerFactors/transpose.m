function A = transpose(A)
    A.IsZero = transpose(A.IsZero);
    A.IsNegative = transpose(A.IsNegative);
    A.Factors = transpose(A.Factors);
    A.Exponents = transpose(A.Exponents);
end