function Y = ceil(X)
    Y = fix(X);
    isFinitePositiveNoninteger = isfinite(X) & X.Numerator.IsNegative==X.Denominator.IsNegative & X~=Y;
    if any(isFinitePositiveNoninteger,"all")
        Y(isFinitePositiveNoninteger) = Y(isFinitePositiveNoninteger)+1;
    end
end