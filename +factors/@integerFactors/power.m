function C = power(A,B)
    arguments
        A   factors.integerFactors
        B   factors.integerFactors
    end
    if any(B.IsNegative,"all")
        C = power(factors.rationalFactors(A),B);
    else
        [A,B] = utility.implicitArrayExpansion(A,B);
        if isempty(A)
            C = factors.integerFactors.empty(size(A));
        else
            if sum(A.IsZero(:))>=sum(B.IsZero(:))
                C = factors.integerFactors.zeros(size(A));
                C.IsZero(B.IsZero) = false;
            else
                C = factors.integerFactors.ones(size(A));
                C.IsZero(A.IsZero) = true;
            end
            C = A;
            C(B.IsZero) = factors.integerFactors.ones(size(C(B.IsZero)));
            absB = uint8(abs(B));
            C.IsNegative(A.IsNegative & mod(absB,2)==0) = false;
            elementIndices = find(~(B.IsZero(:) | A.IsZero(:))).';
            for elementIndex = elementIndices
                if any(A.Exponents{elementIndex}>idivide(intmax("uint8"),absB(elementIndex)))
                    errorID = "integerFactors:power:exponentSumExceedsIntMax";
                    message = "Product of factor exponents and integer power exceeds the largest value of type uint8. See INTMAX.";
                    error(errorID,message)
                end
                C.Exponents{elementIndex} = C.Exponents{elementIndex}.*absB(elementIndex);
            end
        end
    end
end