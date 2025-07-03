function TF = le(A,B)
% LE - Determine less than or equal to
%   This function returns a logical array indicating where the first input
%   array is less than or equal to the second input array.
%
%   Syntax
%     A <= B
%     LE(A,B)
%
%   Input Arguments
%     A - Operands
%       scalars | vectors | matrices | multidimensional arrays
%     B - Operands
%       scalars | vectors | matrices | multidimensional arrays
%
%   See also eq, ge, gt, lt, ne
    TF = A<B | A==B;
end