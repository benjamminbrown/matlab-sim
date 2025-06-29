function varargout = commonFactors(A,B)
    arguments (Input)
        A   factors.integerFactors
        B   factors.integerFactors
    end
    [A,B] = utility.implicitArrayExpansion(A,B);
    if isempty(A)
        [varargout{1:nargout}] = deal(factors.integerFactors.empty(size(A)));
    else
        R = factors.integerFactors.ones(size(A));
        Ar = A;
        Br = B;
        elementIndices = find(~A.IsZero(:) & ~B.IsZero(:)).';
        for elementIndex = elementIndices
            if A.IsNegative(elementIndex) && B.IsNegative(elementIndex)
                R.IsNegative(elementIndex) = true;
                Ar.IsNegative(elementIndex) = false;
                Br.IsNegative(elementIndex) = false;
            end
            commonFactors = Ar.Factors{elementIndex}(ismember(Ar.Factors{elementIndex},Br.Factors{elementIndex}));
            if ~isempty(commonFactors)
                R.Factors{elementIndex} = commonFactors;
                numberOfFactors = length(R.Factors{elementIndex});
                R.Exponents{elementIndex} = zeros([1,numberOfFactors],"uint8");
                for factorIndexR = 1:numberOfFactors
                    factorIndexAr = find(Ar.Factors{elementIndex}==R.Factors{elementIndex}(factorIndexR));
                    factorIndexBr = find(Br.Factors{elementIndex}==R.Factors{elementIndex}(factorIndexR));
                    if Ar.Exponents{elementIndex}(factorIndexAr)==Br.Exponents{elementIndex}(factorIndexBr)
                        R.Exponents{elementIndex}(factorIndexR) = Ar.Exponents{elementIndex}(factorIndexAr);
                        Ar.Factors{elementIndex}(factorIndexAr) = [];
                        Ar.Exponents{elementIndex}(factorIndexAr) = [];
                        Br.Factors{elementIndex}(factorIndexBr) = [];
                        Br.Exponents{elementIndex}(factorIndexBr) = [];
                    elseif Ar.Exponents{elementIndex}(factorIndexAr)<Br.Exponents{elementIndex}(factorIndexBr)
                        R.Exponents{elementIndex}(factorIndexR) = Ar.Exponents{elementIndex}(factorIndexAr);
                        Ar.Factors{elementIndex}(factorIndexAr) = [];
                        Ar.Exponents{elementIndex}(factorIndexAr) = [];
                        Br.Exponents{elementIndex}(factorIndexBr) = Br.Exponents{elementIndex}(factorIndexBr)-R.Exponents{elementIndex}(factorIndexR);
                    else
                        R.Exponents{elementIndex}(factorIndexR) = Br.Exponents{elementIndex}(factorIndexAr);
                        Ar.Exponents{elementIndex}(factorIndexAr) = Ar.Exponents{elementIndex}(factorIndexAr)-R.Exponents{elementIndex}(factorIndexR);
                        Br.Factors{elementIndex}(factorIndexBr) = [];
                        Br.Exponents{elementIndex}(factorIndexBr) = [];
                    end
                end
            end
        end
        switch nargout
            case {0,1}
                [varargout{1:nargout}] = R;
            case 3
                varargout{1} = R;
                varargout{2} = Ar;
                varargout{3} = Br;
            otherwise
                errorID = "integerFactors:commonFactors:outputArgumentMismatch";
                message = "Number of output arguments must be one or three.";
                error(errorID,message)
        end
    end
end