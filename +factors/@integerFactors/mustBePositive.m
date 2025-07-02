function mustBePositive(A)
% MUSTBEPOSITIVE - Validate that value is positive
%   This function throws an error if any value in the
%   factors.integerFactors array is not positive.
% 
%   Syntax
%     mustBePositive(A)
% 
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
    if any(A.IsZero | A.IsNegative,"all")
        errorID = "integerFactors:mustBePositive";
        message = "Value must be positive.";
        throwAsCaller(MException(errorID,message))
    end
end