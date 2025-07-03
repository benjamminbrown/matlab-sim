function varargout = commonFactors(A,B)
    arguments (Input)
        A   factors.integerFactors
        B   factors.integerFactors
    end
    try
        nargoutchk(0,3)
        message = "Number of output arguments must be one or three.";
        assert(nargout~=2,message)
    catch ME
        errorID = "integerFactors:validation:nargoutchk";
        error(errorID,ME.message)
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
        if nargout<=1
            [varargout{1:nargout}] = R;
        else
            varargout{1} = R;
            varargout{2} = Ar;
            varargout{3} = Br;
        end
    end
end