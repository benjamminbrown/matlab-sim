function Y = sign(X)
    Y = X;
    Y.Numerator = sign(X.Numerator);
    isInfinite = isinf(X);
    if any(isInfinite,"all")
        Y.Denominator(isInfinite) = factors.integerFactors((-1).^X.Denominator.IsNegative(isInfinite));
    end
    isNoninfinite = ~isInfinite;
    if any(isNoninfinite,"all")
        Y.Denominator(isNoninfinite) = sign(X.Denominator(isNoninfinite));
    end
end