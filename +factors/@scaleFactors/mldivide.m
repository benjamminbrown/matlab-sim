function C = mldivide(A,B)
% MLDIVIDE - Solve systems of linear equations Ax = B for x
%   This function solves the system of linear equations A*x = B for x. For
%   factors.scaleFactors operands, this overloaded function will only work
%   if at least one of the operands is a scalar.
%
%   Syntax
%     x = A\B
%     x = MLDIVIDE(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also mrdivide, ldivide, rdivide
    if ~(isscalar(A) || isscalar(B))
        % Throw error if neither input is a scalar
        errorID = "scaleFactors:mldivide:matrixDivisionNotSupported";
        message = "The matrix divide method is not supported for two nonscalar operands of type 'factors.scaleFactors'.";
        error(errorID,message)
    else
        % Pass operands to ldivide method
        C = ldivide(A,B);
    end
end