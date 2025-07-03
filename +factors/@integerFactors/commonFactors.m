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
        isNontrivial = ~(A.IsZero | B.IsZero);
        if any(isNontrivial,"all")
            indices = find(isNontrivial);
            for elementIndex = 1:numel(indices)
                index = indices(elementIndex);
                if A.IsNegative(index) && B.IsNegative(index)
                    R.IsNegative(index) = true;
                    Ar.IsNegative(index) = false;
                    Br.IsNegative(index) = false;
                end
                commonFactors = Ar.Factors{index}(ismember(Ar.Factors{index},Br.Factors{index}));
                if ~isempty(commonFactors)
                    R.Factors{index} = commonFactors;
                    numberOfFactors = length(R.Factors{index});
                    R.Exponents{index} = zeros([1,numberOfFactors],"uint8");
                    for factorIndexR = 1:numberOfFactors
                        factorIndexAr = find(Ar.Factors{index}==R.Factors{index}(factorIndexR));
                        factorIndexBr = find(Br.Factors{index}==R.Factors{index}(factorIndexR));
                        if Ar.Exponents{index}(factorIndexAr)==Br.Exponents{index}(factorIndexBr)
                            R.Exponents{index}(factorIndexR) = Ar.Exponents{index}(factorIndexAr);
                            Ar.Factors{index}(factorIndexAr) = [];
                            Ar.Exponents{index}(factorIndexAr) = [];
                            Br.Factors{index}(factorIndexBr) = [];
                            Br.Exponents{index}(factorIndexBr) = [];
                        elseif Ar.Exponents{index}(factorIndexAr)<Br.Exponents{index}(factorIndexBr)
                            R.Exponents{index}(factorIndexR) = Ar.Exponents{index}(factorIndexAr);
                            Ar.Factors{index}(factorIndexAr) = [];
                            Ar.Exponents{index}(factorIndexAr) = [];
                            Br.Exponents{index}(factorIndexBr) = Br.Exponents{index}(factorIndexBr)-R.Exponents{index}(factorIndexR);
                        else
                            R.Exponents{index}(factorIndexR) = Br.Exponents{index}(factorIndexAr);
                            Ar.Exponents{index}(factorIndexAr) = Ar.Exponents{index}(factorIndexAr)-R.Exponents{index}(factorIndexR);
                            Br.Factors{index}(factorIndexBr) = [];
                            Br.Exponents{index}(factorIndexBr) = [];
                        end
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