function A = power(A,B)
% POWER - Element-wise power
%   This function raises each element of the first operand to the
%   corresponding power in the second operand.
%
%   Syntax
%     C = A.^B
%     C = POWER(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also mpower, nthroot, sqrt
    arguments
        A   factors.scaleFactors
        B   factors.rationalFactors
    end
    % Implicitly expand singleton dimensions of input arrays
    [A,B] = utility.implicitArrayExpansion(A,B);
    if ~isempty(A)
        for elementIndex = 1:numel(A)
            % Multiply prime factor exponents by power
            A.Exponents{elementIndex} = A.Exponents{elementIndex}.*B(elementIndex);
        end
    end
end