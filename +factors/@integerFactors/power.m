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
            isNontrivial = ~(A.IsZero | B.IsZero);
            if any(isNontrivial,"all")
                C(isNontrivial) = A(isNontrivial);
                absB = uint8(abs(B(isNontrivial)));
                CIndices = find(isNontrivial);
                for elementIndex = 1:numel(absB)
                    if any(A.Exponents{CIndices(elementIndex)}>idivide(intmax("uint8"),absB(elementIndex)))
                        errorID = "integerFactors:power:exponentSumExceedsIntMax";
                        message = "Product of factor exponents and integer power exceeds the largest value of type uint8. See INTMAX.";
                        error(errorID,message)
                    end
                    C.Exponents{CIndices(elementIndex)} = C.Exponents{CIndices(elementIndex)}.*absB(elementIndex);
                end
                C.IsNegative(CIndices(A.IsNegative(isNontrivial) & mod(absB,2)==0)) = false;
            end
        end
    end
end