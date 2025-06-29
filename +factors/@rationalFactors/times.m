function C = times(A,B)
    arguments
        A   factors.rationalFactors
        B   factors.rationalFactors
    end
    C = factors.rationalFactors(A.Numerator.*B.Numerator, ...
                                A.Denominator.*B.Denominator);
end