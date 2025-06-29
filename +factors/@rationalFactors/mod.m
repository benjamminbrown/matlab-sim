function B = mod(A,M)
    arguments
        A   factors.rationalFactors
        M   factors.rationalFactors
    end
    [A,M] = utility.implicitArrayExpansion(A,M);
    B = factors.rationalFactors.NaN(size(A));
    isZeroM = M.Numerator.IsZero & ~M.Denominator.IsZero;
    if any(isZeroM,"all")
        B(isZeroM) = A(isZeroM);
    end
    isValidMod = isfinite(A) & ~isZeroM;
    if any(isValidMod,"all")
        B(isValidMod) = factors.rationalFactors(mod(A.Numerator(isValidMod).*M.Denominator(isValidMod),M.Numerator(isValidMod).*A.Denominator(isValidMod)), ...
                                    A.Denominator(isValidMod).*M.Denominator(isValidMod));
    end
end