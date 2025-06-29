function Y = floor(X)
    Y = fix(X);
    isFiniteNegativeNoninteger = isfinite(X) & X.Numerator.IsNegative~=X.Denominator.IsNegative & X~=Y;
    if any(isFiniteNegativeNoninteger,"all")
        Y(isFiniteNegativeNoninteger) = Y(isFiniteNegativeNoninteger)-1;
    end
end