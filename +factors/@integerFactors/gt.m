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
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also eq, ge, le, lt, ne

    % Implicitly expand singleton dimensions of input arrays
    [A,B] = utility.implicitArrayExpansion(A,B);
    if isempty(A)
        % Return empty array
        TF = logical.empty(size(A));
    else
        % Nontrivial calculation will be required if A and B are finite
        TF = ~(isnan(A) | isnan(B)) & ...
             ((isinf(A) & double(sign(A))>0) | (isinf(B) & double(sign(B))<0));
        isNontrivial = isfinite(A) & isfinite(B) & A~=B;
        if any(isNontrivial,"all")
            if ~isa(A,"factors.integerFactors")
                % Cast nontrivial elements as factors.integerFactors
                nontrivialA = factors.integerFactors(A(isNontrivial));
            else
                nontrivialA = A(isNontrivial);
            end
            if ~isa(B,"factors.integerFactors")
                % Cast nontrivial elements as factors.integerFactors
                nontrivialB = factors.integerFactors(B(isNontrivial));
            else
                nontrivialB = B(isNontrivial);
            end
            % Detailed inspection is necessary when signs are equal
            TF(isNontrivial) = (nontrivialB.IsZero & ~nontrivialA.IsNegative) | ...
                               ((nontrivialA.IsZero | nontrivialA.IsNegative~=nontrivialB.IsNegative) & nontrivialB.IsNegative);
            isComplicated = ~nontrivialB.IsZero & ~nontrivialA.IsZero & nontrivialA.IsNegative==nontrivialB.IsNegative;
            if any(isComplicated,"all")
                % Find common factors and compare reduced elements
                [R,Ar,Br] = commonFactors(nontrivialA(isComplicated),nontrivialB(isComplicated));
                TFIndices = find(isNontrivial);
                TFIndices = TFIndices(isComplicated);
                for RIndex = 1:numel(R)
                    isUnitAr = isempty(Ar.Factors{RIndex});
                    isUnitBr = isempty(Br.Factors{RIndex});
                    if ~isUnitAr && isUnitBr
                        % Absolute value of A exceeds B
                        TF(TFIndices(RIndex)) = true;
                    elseif isUnitAr && ~isUnitBr
                        % Absolute value of B exceeds A
                        TF(TFIndices(RIndex)) = false;
                    else
                        % Compare factors to determine absolute order
                        numberOfFactorsAr = length(Ar.Factors{RIndex});
                        numberOfFactorsBr = length(Br.Factors{RIndex});
                        if numberOfFactorsAr>=numberOfFactorsBr && ...
                                all(Ar.Factors{RIndex}(numberOfFactorsAr-(numberOfFactorsBr-1):numberOfFactorsAr)>Br.Factors{RIndex}) && ...
                                all(Ar.Exponents{RIndex}(numberOfFactorsAr-(numberOfFactorsBr-1):numberOfFactorsAr)>=Br.Exponents{RIndex})
                            TF(TFIndices(RIndex)) = true;
                        elseif numberOfFactorsBr>=numberOfFactorsAr && ...
                                all(Br.Factors{RIndex}(numberOfFactorsBr-(numberOfFactorsAr-1):numberOfFactorsBr)>Ar.Factors{RIndex}) && ...
                                all(Br.Exponents{RIndex}(numberOfFactorsBr-(numberOfFactorsAr-1):numberOfFactorsBr)>=Ar.Exponents{RIndex})
                            TF(TFIndices(RIndex)) = false;
                        else
                            % Compare integers since all else failed
                            TF(TFIndices(RIndex)) = uint64(Ar(RIndex))>uint64(Br(RIndex));
                        end
                    end
                    if R.IsNegative(RIndex)
                        % Flip logical value if A and B are negative
                        TF(TFIndices(RIndex)) = ~TF(TFIndices(RIndex));
                    end
                end
            end
        end
    end
end