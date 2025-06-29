function TF = isfinite(A)
    TF = ~A.Denominator.IsZero;
end