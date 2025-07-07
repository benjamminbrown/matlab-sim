function A = permute(A,dimorder)
    A.Numerator = permute(A.Numerator,dimorder);
    A.Denominator = permute(A.Denominator,dimorder);
end