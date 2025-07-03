function TF = lt(A,B)
% LT - Determine less than
%   This function returns a logical array indicating where the first input
%   array is less than the second input array.
%
%   Syntax
%     A < B
%     LT(A,B)
%
%   Input Arguments
%     A - Operands
%       scalars | vectors | matrices | multidimensional arrays
%     B - Operands
%       scalars | vectors | matrices | multidimensional arrays
%
%   See also eq, ge, gt, le, ne
    [A,B] = utility.implicitArrayExpansion(A,B);
    if isempty(A)
        TF = logical.empty(size(A));
    else
        TF = ~isnan(A) & ~isnan(B);
        if any(TF,"all")
            TF(TF) = ~(A(TF)>=B(TF));
        end
    end
end