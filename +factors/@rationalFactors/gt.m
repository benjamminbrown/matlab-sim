function TF = gt(A,B)
    [A,B] = utility.implicitArrayExpansion(A,B);
    if isempty(A)
        TF = logical.empty(size(A));
    else
        TF = ~(isnan(A) | isnan(B));
        isInfiniteA = isinf(A);
        isInfiniteB = isinf(B);
        isDualInfiniteComparison = isInfiniteA & isInfiniteB;
        if any(isDualInfiniteComparison,"all")
            TF(isDualInfiniteComparison) = double(sign(A(isDualInfiniteComparison)))>double(sign(B(isDualInfiniteComparison)));
        end
        isFiniteA = isfinite(A);
        isFiniteB = isfinite(B);
        isSingularInfiniteComparison = (isInfiniteA & isFiniteB) | (isFiniteA & isInfiniteB);
        if any(isSingularInfiniteComparison,"all")
            TF(isSingularInfiniteComparison) = (isInfiniteA(isSingularInfiniteComparison) & double(sign(A(isSingularInfiniteComparison)))>0) | ...
                                               (isInfiniteB(isSingularInfiniteComparison) & double(sign(B(isSingularInfiniteComparison)))<0);
        end
        isEqual = A==B;
        TF(isEqual) = false;
        isNontrivial = isFiniteA & isFiniteB & ~isEqual;
        if any(isNontrivial,"all")
            if ~isa(A,"factors.rationalFactors")
                nontrivialA = factors.rationalFactors(A(isNontrivial));
            else
                nontrivialA = A(isNontrivial);
            end
            if ~isa(B,"factors.rationalFactors")
                nontrivialB = factors.rationalFactors(B(isNontrivial));
            else
                nontrivialB = B(isNontrivial);
            end
            isNegativeA = nontrivialA.Numerator.IsNegative~=nontrivialA.Denominator.IsNegative;
            isNegativeB = nontrivialB.Numerator.IsNegative~=nontrivialB.Denominator.IsNegative;
            TF(isNontrivial) = (nontrivialB.Numerator.IsZero & ~isNegativeA) | ...
                               ((nontrivialA.Numerator.IsZero | isNegativeA~=isNegativeB) & isNegativeB);
            isComplicated = ~nontrivialB.Numerator.IsZero & ~nontrivialA.Numerator.IsZero & isNegativeA==isNegativeB;
            if any(isComplicated,"all")
                TFIndices = find(isNontrivial);
                TF(TFIndices(isComplicated)) = abs(nontrivialA.Numerator(isComplicated).*nontrivialB.Denominator(isComplicated))>abs(nontrivialB.Numerator(isComplicated).*nontrivialA.Denominator(isComplicated));
                if any(isNegativeA(isComplicated))
                    TF(TFIndices(isComplicated & isNegativeA)) = ~TF(TFIndices(isComplicated & isNegativeA));
                end
            end
        end
    end
end