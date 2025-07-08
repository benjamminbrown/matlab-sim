function A = transpose(A)
    A.Numerator = transpose(A.Numerator);
    A.Denominator = transpose(A.Denominator);
end