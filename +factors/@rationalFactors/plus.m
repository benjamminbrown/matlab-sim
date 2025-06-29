function C = plus(A,B)
    arguments
        A   factors.rationalFactors
        B   factors.rationalFactors
    end
    C = factors.rationalFactors(A.Numerator.*B.Denominator+B.Numerator.*A.Denominator, ...
                                A.Denominator.*B.Denominator);
end