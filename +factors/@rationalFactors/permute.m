function B = permute(A,dimorder)
    B = A;
    B.Numerator = permute(A.Numerator,dimorder);
    B.Denominator = permute(A.Denominator,dimorder);
end