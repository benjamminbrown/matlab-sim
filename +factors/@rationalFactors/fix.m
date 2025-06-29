function Y = fix(X)
    Y = X;
    isFinite = isfinite(X);
    if any(isFinite,"all")
        absN = uint64(abs(X.Numerator(isFinite)));
        absD = uint64(abs(X.Denominator(isFinite)));
        Y(isFinite) = factors.rationalFactors((absN-mod(absN,absD))./absD);
        isFiniteNegative = isFinite & X.Numerator.IsNegative~=X.Denominator.IsNegative;
        if any(isFiniteNegative,"all")
            Y(isFiniteNegative) = -Y(isFiniteNegative);
        end
    end
end