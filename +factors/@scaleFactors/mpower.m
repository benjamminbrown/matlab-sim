function C = mpower(A,B)
% MPOWER - Matrix power
%   This function returns the result of the left operand raised to the
%   power of the right operand. Currently, matrix operations are not
%   supported and this function will only work if both operands are
%   scalars.
%
%   Syntax
%     C = A^B
%     C = MPOWER(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also power
    if ~(isscalar(A) && isscalar(B))
        % Throw error if either input is not a scalar
        errorID = "scaleFactors:mpower:matrixPowerNotSupported";
        message = "The matrix power method is not supported for nonscalar operands of type 'factors.scaleFactors'.";
        error(errorID,message)
    else
        % Pass operands to power method
        C = power(A,B);
    end
end