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
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also eq, gt, le, lt, ne
    TF = A>B | A==B;
end