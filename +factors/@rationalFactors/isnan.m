function TF = isnan(A)
    TF = A.Denominator.IsZero & A.Numerator.IsZero;
end