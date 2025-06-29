function B = transpose(A)
    B = A;
    B.Numerator = transpose(A.Numerator);
    B.Denominator = transpose(A.Denominator);
end