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
%     A - Operands
%       scalars | vectors | matrices | multidimensional arrays
%     B - Operands
%       scalars | vectors | matrices | multidimensional arrays
%
%   See also ge, gt, le, lt, ne
    [A,B] = utility.implicitArrayExpansion(A,B);
    if isempty(A)
        TF = logical.empty(size(A));
    else
        TF = isfinite(A) & isfinite(B);
        if any(TF,"all")
            if ~isa(A,"factors.integerFactors")
                nontrivialA = factors.integerFactors(A(TF));
            else
                nontrivialA = A(TF);
            end
            if ~isa(B,"factors.integerFactors")
                nontrivialB = factors.integerFactors(B(TF));
            else
                nontrivialB = B(TF);
            end
            TFIndices = find(TF(:));
            for elementIndex = 1:numel(nontrivialA)
                TF(TFIndices(elementIndex)) = (nontrivialA.IsZero(elementIndex) && nontrivialB.IsZero(elementIndex)) || ...
                                              nontrivialA.IsZero(elementIndex)==nontrivialB.IsZero(elementIndex) && ...
                                              nontrivialA.IsNegative(elementIndex)==nontrivialB.IsNegative(elementIndex) && ...
                                              length(nontrivialA.Factors{elementIndex})==length(nontrivialB.Factors{elementIndex}) && ...
                                              all(nontrivialA.Factors{elementIndex}==nontrivialB.Factors{elementIndex}) && ...
                                              all(nontrivialA.Exponents{elementIndex}==nontrivialB.Exponents{elementIndex});
            end
        end
    end
end