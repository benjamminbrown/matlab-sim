function C = times(A,B)
    arguments
        A   factors.integerFactors
        B   factors.integerFactors
    end
    [A,B] = utility.implicitArrayExpansion(A,B);
    if isempty(A)
        C = factors.integerFactors.empty(size(A));
    else
        C = factors.integerFactors.zeros(size(A));
        C.IsZero = A.IsZero | B.IsZero;
        C.IsNegative = A.IsNegative~=B.IsNegative;
        isNonzero = ~C.IsZero;
        isNontrivial = ~(cellfun(@(Factors) isempty(Factors),A.Factors(isNonzero)) & cellfun(@(Factors) isempty(Factors),B.Factors(isNonzero)));
        if any(isNontrivial,"all")
            elementIndices = find(isNonzero);
            elementIndices = elementIndices(isNontrivial);
            for elementIndex = elementIndices
                C.Factors{elementIndex} = unique([A.Factors{elementIndex},B.Factors{elementIndex}]);
                numberOfFactors = length(C.Factors{elementIndex});
                C.Exponents{elementIndex} = zeros([1,numberOfFactors],"uint8");
                for factorIndexC = 1:numberOfFactors
                    factorIndexA = find(A.Factors{elementIndex}==C.Factors{elementIndex}(factorIndexC));
                    factorIndexB = find(B.Factors{elementIndex}==C.Factors{elementIndex}(factorIndexC));
                    if isempty(factorIndexA)
                        C.Exponents{elementIndex}(factorIndexC) = B.Exponents{elementIndex}(factorIndexB);
                    elseif isempty(factorIndexB)
                        C.Exponents{elementIndex}(factorIndexC) = A.Exponents{elementIndex}(factorIndexA);
                    else
                        if A.Exponents{elementIndex}(factorIndexA)>intmax("uint8")-B.Exponents{elementIndex}(factorIndexB)
                            errorID = "integerFactors:times:exponentSumExceedsIntMax";
                            message = "Sum of factor exponents exceeds the largest value of type uint8. See INTMAX.";
                            error(errorID,message)
                        end
                        C.Exponents{elementIndex}(factorIndexC) = uint64(A.Exponents{elementIndex}(factorIndexA))+uint64(B.Exponents{elementIndex}(factorIndexB));
                    end
                end
            end
        end
    end
end