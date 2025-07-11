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
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also eq, ge, gt, le, lt
    TF = ~(A==B);
end