function TF = eq(A,B)
    [A,B] = utility.implicitArrayExpansion(A,B);
    if isempty(A)
        TF = logical.empty(size(A));
    else
        TF = ~(isnan(A) | isnan(B));
        isInfiniteA = isinf(A);
        isInfiniteB = isinf(B);
        isDualInfiniteComparison = isInfiniteA & isInfiniteB;
        if any(isDualInfiniteComparison,"all")
            TF(isDualInfiniteComparison) = double(sign(A(isDualInfiniteComparison)))==double(sign(B(isDualInfiniteComparison)));
        end
        isFiniteA = isfinite(A);
        isFiniteB = isfinite(B);
        isSingularInfiniteComparison = (isInfiniteA & isFiniteB) | (isFiniteA & isInfiniteB);
        if any(isSingularInfiniteComparison,"all")
            TF(isSingularInfiniteComparison) = false;
        end
        isNontrivial = isFiniteA & isFiniteB;
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
            TF(isNontrivial) = (nontrivialA.Numerator.IsZero & nontrivialB.Numerator.IsZero) | ...
                               (nontrivialA.Numerator.IsNegative==nontrivialA.Denominator.IsNegative)==(nontrivialB.Numerator.IsNegative==nontrivialB.Denominator.IsNegative) & ...
                               abs(nontrivialA.Numerator)==abs(nontrivialB.Numerator) & ...
                               abs(nontrivialA.Denominator)==abs(nontrivialB.Denominator);
        end
    end
end