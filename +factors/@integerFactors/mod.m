function B = mod(A,M)
    arguments
        A   factors.integerFactors
        M   factors.integerFactors
    end
    [A,M] = utility.implicitArrayExpansion(A,M);
    B = A-M.*factors.integerFactors(floor(A./M));
    if any(M.IsZero,"all")
        B(M.IsZero) = A(M.IsZero);
    end
end