function TF = isinf(A)
    TF = A.Denominator.IsZero & ~A.Numerator.IsZero;
end