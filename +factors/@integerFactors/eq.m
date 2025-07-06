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
        % Nontrivial calculation will be required if A and B are finite
        TF = isfinite(A) & isfinite(B);
        if any(TF,"all")
            if ~isa(A,"factors.integerFactors")
                % Cast nontrivial elements as factors.integerFactors
                nontrivialA = factors.integerFactors(A(TF));
            else
                nontrivialA = A(TF);
            end
            if ~isa(B,"factors.integerFactors")
                % Cast nontrivial elements as factors.integerFactors
                nontrivialB = factors.integerFactors(B(TF));
            else
                nontrivialB = B(TF);
            end
            TFIndices = find(TF(:));
            for nontrivialIndex = 1:numel(nontrivialA)
                % Check elements for equality
                TF(TFIndices(nontrivialIndex)) = (nontrivialA.IsZero(nontrivialIndex) && nontrivialB.IsZero(nontrivialIndex)) || ...
                                                 nontrivialA.IsZero(nontrivialIndex)==nontrivialB.IsZero(nontrivialIndex) && ...
                                                 nontrivialA.IsNegative(nontrivialIndex)==nontrivialB.IsNegative(nontrivialIndex) && ...
                                                 length(nontrivialA.Factors{nontrivialIndex})==length(nontrivialB.Factors{nontrivialIndex}) && ...
                                                 all(nontrivialA.Factors{nontrivialIndex}==nontrivialB.Factors{nontrivialIndex}) && ...
                                                 all(nontrivialA.Exponents{nontrivialIndex}==nontrivialB.Exponents{nontrivialIndex});
            end
        end
    end
end