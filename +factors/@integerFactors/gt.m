function TF = gt(A,B)
% GT - Determine greater than
%   This function returns a logical array indicating where the first input
%   array is greater than the second input array.
%
%   Syntax
%     A > B
%     GT(A,B)
%
%   Input Arguments
%     A - Operands
%       scalars | vectors | matrices | multidimensional arrays
%     B - Operands
%       scalars | vectors | matrices | multidimensional arrays
%
%   See also eq, ge, le, lt, ne
    [A,B] = utility.implicitArrayExpansion(A,B);
    if isempty(A)
        TF = logical.empty(size(A));
    else
        TF = ~(isnan(A) | isnan(B)) & ...
             ((isinf(A) & double(sign(A))>0) | (isinf(B) & double(sign(B))<0));
        isNontrivial = isfinite(A) & isfinite(B) & A~=B;
        if any(isNontrivial,"all")
            if ~isa(A,"factors.integerFactors")
                nontrivialA = factors.integerFactors(A(isNontrivial));
            else
                nontrivialA = A(isNontrivial);
            end
            if ~isa(B,"factors.integerFactors")
                nontrivialB = factors.integerFactors(B(isNontrivial));
            else
                nontrivialB = B(isNontrivial);
            end
            TF(isNontrivial) = (nontrivialB.IsZero & ~nontrivialA.IsNegative) | ...
                               ((nontrivialA.IsZero | nontrivialA.IsNegative~=nontrivialB.IsNegative) & nontrivialB.IsNegative);
            isComplicated = ~nontrivialB.IsZero & ~nontrivialA.IsZero & nontrivialA.IsNegative==nontrivialB.IsNegative;
            if any(isComplicated,"all")
                [R,Ar,Br] = commonFactors(nontrivialA(isComplicated),nontrivialB(isComplicated));
                TFIndices = find(isNontrivial);
                TFIndices = TFIndices(isComplicated);
                for elementIndex = 1:numel(R)
                    isUnitAr = isempty(Ar.Factors{elementIndex});
                    isUnitBr = isempty(Br.Factors{elementIndex});
                    if ~isUnitAr && isUnitBr
                        TF(TFIndices(elementIndex)) = true;
                    elseif isUnitAr && ~isUnitBr
                        TF(TFIndices(elementIndex)) = false;
                    else
                        numberOfFactorsAr = length(Ar.Factors{elementIndex});
                        numberOfFactorsBr = length(Br.Factors{elementIndex});
                        if numberOfFactorsAr>=numberOfFactorsBr && ...
                                all(Ar.Factors{elementIndex}(numberOfFactorsAr-(numberOfFactorsBr-1):numberOfFactorsAr)>Br.Factors{elementIndex}) && ...
                                all(Ar.Exponents{elementIndex}(numberOfFactorsAr-(numberOfFactorsBr-1):numberOfFactorsAr)>=Br.Exponents{elementIndex})
                            TF(TFIndices(elementIndex)) = true;
                        elseif numberOfFactorsBr>=numberOfFactorsAr && ...
                                all(Br.Factors{elementIndex}(numberOfFactorsBr-(numberOfFactorsAr-1):numberOfFactorsBr)>Ar.Factors{elementIndex}) && ...
                                all(Br.Exponents{elementIndex}(numberOfFactorsBr-(numberOfFactorsAr-1):numberOfFactorsBr)>=Ar.Exponents{elementIndex})
                            TF(TFIndices(elementIndex)) = false;
                        else
                            TF(TFIndices(elementIndex)) = uint64(Ar(elementIndex))>uint64(Br(elementIndex));
                        end
                    end
                    if R.IsNegative(elementIndex)
                        TF(TFIndices(elementIndex)) = ~TF(TFIndices(elementIndex));
                    end
                end
            end
        end
    end
end