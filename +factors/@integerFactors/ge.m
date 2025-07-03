function TF = ge(A,B)
% GE - Determine greater than or equal to
%   This function returns a logical array indicating where the first input
%   array is greater than or equal to the second input array.
%
%   Syntax
%     A >= B
%     GE(A,B)
%
%   Input Arguments
%     A - Operands
%       scalars | vectors | matrices | multidimensional arrays
%     B - Operands
%       scalars | vectors | matrices | multidimensional arrays
%
%   See also eq, gt, le, lt, ne
    TF = A>B | A==B;
end