function R = rem(A,B)
    arguments
        A   factors.integerFactors
        B   factors.integerFactors
    end
    [A,B] = utility.implicitArrayExpansion(A,B);
    R = A-B.*factors.integerFactors(fix(A./B));
    if any(B.IsZero,"all")
        R(B.IsZero) = factors.integerFactors.zeros(size(R(B.IsZero)));
    end
end