function TF = ne(A,B)
% NE - Determine inequality
%   This function returns a logical array indicating where the first input
%   array is not equal to the second input array.
%
%   Syntax
%     A ~= B
%     NE(A,B)
%
%   Input Arguments
%     A - Operands
%       scalars | vectors | matrices | multidimensional arrays
%     B - Operands
%       scalars | vectors | matrices | multidimensional arrays
%
%   See also eq, ge, gt, le, lt
    TF = ~(A==B);
end