function X = sign(X)
    X.Numerator = sign(X.Numerator);
    isInfinite = isinf(X);
    if any(isInfinite,"all")
        X.Denominator(isInfinite) = factors.integerFactors((-1).^X.Denominator.IsNegative(isInfinite));
    end
    isNoninfinite = ~isInfinite;
    if any(isNoninfinite,"all")
        X.Denominator(isNoninfinite) = sign(X.Denominator(isNoninfinite));
    end
end