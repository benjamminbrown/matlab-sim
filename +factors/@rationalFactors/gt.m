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
        % Comparison is trivially false if operands are NaN or equal
        TF = ~(isnan(A) | isnan(B) | A==B);
        % Perform infinite comparisons
        isInfiniteA = isinf(A);
        isInfiniteB = isinf(B);
        isDualInfiniteComparison = isInfiniteA & isInfiniteB;
        if any(isDualInfiniteComparison,"all")
            TF(isDualInfiniteComparison) = double(sign(A(isDualInfiniteComparison)))>double(sign(B(isDualInfiniteComparison)));
        end
        isFiniteA = isfinite(A);
        isFiniteB = isfinite(B);
        isSingularInfiniteComparison = (isInfiniteA & isFiniteB) | (isFiniteA & isInfiniteB);
        if any(isSingularInfiniteComparison,"all")
            TF(isSingularInfiniteComparison) = (isInfiniteA(isSingularInfiniteComparison) & double(sign(A(isSingularInfiniteComparison)))>0) | ...
                                               (isInfiniteB(isSingularInfiniteComparison) & double(sign(B(isSingularInfiniteComparison)))<0);
        end
        % Find where nontrivial calculation will be required
        isNontrivial = isFiniteA & isFiniteB & ~isEqual;
        if any(isNontrivial,"all")
            if ~isa(A,"factors.rationalFactors")
                % Cast nontrivial elements as factors.rationalFactors
                nontrivialA = factors.rationalFactors(A(isNontrivial));
            else
                nontrivialA = A(isNontrivial);
            end
            if ~isa(B,"factors.rationalFactors")
                % Cast nontrivial elements as factors.rationalFactors
                nontrivialB = factors.rationalFactors(B(isNontrivial));
            else
                nontrivialB = B(isNontrivial);
            end
            % Check for simpler cases
            isNegativeA = nontrivialA.Numerator.IsNegative~=nontrivialA.Denominator.IsNegative;
            isNegativeB = nontrivialB.Numerator.IsNegative~=nontrivialB.Denominator.IsNegative;
            TF(isNontrivial) = (nontrivialB.Numerator.IsZero & ~isNegativeA) | ...
                               ((nontrivialA.Numerator.IsZero | isNegativeA~=isNegativeB) & isNegativeB);
            % More complicated comparison is needed when signs are equal
            isComplicated = ~nontrivialB.Numerator.IsZero & ~nontrivialA.Numerator.IsZero & isNegativeA==isNegativeB;
            if any(isComplicated,"all")
                TFIndices = find(isNontrivial);
                TF(TFIndices(isComplicated)) = abs(nontrivialA.Numerator(isComplicated).*nontrivialB.Denominator(isComplicated))>abs(nontrivialB.Numerator(isComplicated).*nontrivialA.Denominator(isComplicated));
                if any(isNegativeA(isComplicated))
                    TF(TFIndices(isComplicated & isNegativeA)) = ~TF(TFIndices(isComplicated & isNegativeA));
                end
            end
        end
    end
end