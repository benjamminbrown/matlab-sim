function X = fix(X)
    isFinite = isfinite(X);
    if any(isFinite,"all")
        isFiniteNegative = isFinite & X.Numerator.IsNegative~=X.Denominator.IsNegative;
        absN = uint64(abs(X.Numerator(isFinite)));
        absD = uint64(abs(X.Denominator(isFinite)));
        X(isFinite) = factors.rationalFactors((absN-mod(absN,absD))./absD);
        if any(isFiniteNegative,"all")
            X(isFiniteNegative) = -X(isFiniteNegative);
        end
    end
end