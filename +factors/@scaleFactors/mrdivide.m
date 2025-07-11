function C = mrdivide(B,A)
% MRDIVIDE - Solve systems of linear equations xA = B for x
%   This function solves the system of linear equations x*A = B for x. For
%   factors.scaleFactors operands, this overloaded function will only work
%   if at least one of the operands is a scalar.
%
%   Syntax
%     x = B/A
%     x = MRDIVIDE(B,A)
%
%   Input Arguments
%     B - Left operand
%       scalar | vector | matrix | multidimensional array
%     A - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also mldivide, rdivide, ldivide
    if ~(isscalar(A) || isscalar(B))
        % Throw error if neither input is a scalar
        errorID = "scaleFactors:mrdivide:matrixDivisionNotSupported";
        message = "The matrix divide method is not supported for two nonscalar operands of type 'factors.scaleFactors'.";
        error(errorID,message)
    else
        % Pass operands to rdivide method
        C = rdivide(B,A);
    end
end