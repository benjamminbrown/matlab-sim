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
    arguments
        A   double
        B   double
    end
    TF = gt(A,B);
end