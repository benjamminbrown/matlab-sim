function C = mtimes(A,B)
% MTIMES - Matrix multiplication
%   This function returns the matrix product of the input arrays. For
%   factors.integerFactors arrays, this overloaded function will only work
%   if at least one of the operands is a scalar.
%
%   Syntax
%     C = A*B
%     C = MTIMES(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also times
    if ~(isscalar(A) || isscalar(B))
        % Throw error if neither input is a scalar
        errorID = "integerFactors:mtimes:matrixMultiplicationNotSupported";
        message = "The matrix times method is not supported for two nonscalar operands of type 'factors.integerFactors'.";
        error(errorID,message)
    else
        % Pass operands to times method
        C = times(A,B);
    end
end