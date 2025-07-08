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
        A   factors.rationalFactors
        B   factors.rationalFactors
    end
    % Initialize result
    C = A;
    % Perform division
    C.Numerator = A.Numerator.*B.Denominator;
    C.Denominator = A.Denominator.*B.Numerator;
    % Remove common factors
    [~,C.Numerator,C.Denominator] = commonFactors(C.Numerator,C.Denominator);
end