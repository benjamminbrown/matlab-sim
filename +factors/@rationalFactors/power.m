function C = power(A,B)
    arguments
        A   factors.rationalFactors
        B   factors.integerFactors
    end
    [A,B] = utility.implicitArrayExpansion(A,B);
    absB = abs(B);
    C = factors.rationalFactors(A.Numerator.^absB,A.Denominator.^absB);
    if any(B.IsNegative,"all")
        [C.Numerator(B.IsNegative),C.Denominator(B.IsNegative)] = deal(C.Denominator(B.IsNegative),C.Numerator(B.IsNegative));
    end
end