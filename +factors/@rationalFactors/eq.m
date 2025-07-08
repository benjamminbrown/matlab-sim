function TF = eq(A,B)
% EQ - Determine equality
%   This function returns a logical array indicating where the input arrays
%   are equal to each other.
%
%   Syntax
%     A == B
%     EQ(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also ge, gt, le, lt, ne

    % Implicitly expand singleton dimensions of input arrays
    [A,B] = utility.implicitArrayExpansion(A,B);
    if isempty(A)
        % Return empty array
        TF = logical.empty(size(A));
    else
        % Equality is trivially false if either operand is NaN
        TF = ~(isnan(A) | isnan(B));
        % Perform infinite comparisons
        isInfiniteA = isinf(A);
        isInfiniteB = isinf(B);
        isDualInfiniteComparison = isInfiniteA & isInfiniteB;
        if any(isDualInfiniteComparison,"all")
            TF(isDualInfiniteComparison) = double(sign(A(isDualInfiniteComparison)))==double(sign(B(isDualInfiniteComparison)));
        end
        isFiniteA = isfinite(A);
        isFiniteB = isfinite(B);
        isSingularInfiniteComparison = (isInfiniteA & isFiniteB) | (isFiniteA & isInfiniteB);
        if any(isSingularInfiniteComparison,"all")
            TF(isSingularInfiniteComparison) = false;
        end
        % Find where nontrivial calculation will be required
        isNontrivial = isFiniteA & isFiniteB;
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
            % Check for equality
            TF(isNontrivial) = (nontrivialA.Numerator.IsZero & nontrivialB.Numerator.IsZero) | ...
                               (nontrivialA.Numerator.IsNegative==nontrivialA.Denominator.IsNegative)==(nontrivialB.Numerator.IsNegative==nontrivialB.Denominator.IsNegative) & ...
                               abs(nontrivialA.Numerator)==abs(nontrivialB.Numerator) & ...
                               abs(nontrivialA.Denominator)==abs(nontrivialB.Denominator);
        end
    end
end