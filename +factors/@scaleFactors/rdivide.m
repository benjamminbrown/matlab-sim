function C = rdivide(A,B)
% RDIVIDE - Right array division
%   This function divides each element of the left array by the
%   corresponding element of the right array.
%
%   Syntax
%     x = A./B
%     x = RDIVIDE(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also ldivide, mrdivide, mldivide
    arguments
        A   factors.scaleFactors
        B   factors.scaleFactors
    end
    % Invert right operand and pass to times method
    C = times(A,B.^-1);
end