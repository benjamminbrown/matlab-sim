function C = plus(A,B)
    arguments
        A   factors.integerFactors
        B   factors.integerFactors
    end
    [R,Ar,Br] = commonFactors(A,B);
    isAr = ~Ar.IsZero & Br.IsZero;
    isBr = Ar.IsZero & ~Br.IsZero;
    isZero = Ar==-Br;
    [~,maxIndex] = max([sum(isAr(:)),sum(isBr(:)),sum(isZero)]);
    if maxIndex<3
        if maxIndex==1
            Cr = Ar;
            Cr(isBr) = Br(isBr);
        else
            Cr = Br;
            Cr(isAr) = Ar(isAr);
        end
        Cr(isZero) = factors.integerFactors.zeros(size(Cr(isZero)));
    else
        Cr = factors.integerFactors.zeros(size(Ar));
        Cr(isAr) = Ar(isAr);
        Cr(isBr) = Br(isBr);
    end
    isNontrivial = ~Ar.IsZero & ~Br.IsZero & Ar~=-Br;
    if any(isNontrivial,"all")
        absAr = uint64(abs(Ar(isNontrivial)));
        absBr = uint64(abs(Br(isNontrivial)));
        absCr = zeros(size(absAr),"uint64");
        isAddition = Ar.IsNegative(isNontrivial)==Br.IsNegative(isNontrivial);
        if any(absAr(isAddition)>intmax("uint64")-absBr(isAddition))
            errorID = "integerFactor:plus:exponentSumExceedsIntMax";
            message = "Sum of reduced operands exceeds the largest value of type uint64. See INTMAX.";
            error(errorID,message)
        end
        absCr(isAddition) = absAr(isAddition)+absBr(isAddition);
        isSubtraction = ~isAddition;
        isGreaterAbsAr = absAr>absBr;
        isSubtractionWithGreaterAbsAr = isSubtraction & isGreaterAbsAr;
        absCr(isSubtractionWithGreaterAbsAr) = absAr(isSubtractionWithGreaterAbsAr)-absBr(isSubtractionWithGreaterAbsAr);
        isSubtractionWithGreaterAbsBr = isSubtraction & ~isGreaterAbsAr;
        absCr(isSubtractionWithGreaterAbsBr) = absBr(isSubtractionWithGreaterAbsBr)-absAr(isSubtractionWithGreaterAbsBr);
        Cr(isNontrivial) = factors.integerFactors(absCr);
        CrIndices = find(isNontrivial);
        isNegativeAr = isSubtractionWithGreaterAbsAr & Ar.IsNegative(CrIndices);
        if any(isNegativeAr)
            Cr(CrIndices(isNegativeAr)) = -Cr(CrIndices(isNegativeAr));
        end
        isNegativeBr = isSubtractionWithGreaterAbsBr & Br.IsNegative(CrIndices);
        if any(isNegativeBr)
            Cr(CrIndices(isNegativeBr)) = -Cr(CrIndices(isNegativeBr));
        end
    end
    C = R.*Cr;
end