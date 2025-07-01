function B = transpose(A)
    B = A;
    B.Factors = transpose(A.Factors);
    B.Exponents = transpose(A.Exponents);
end