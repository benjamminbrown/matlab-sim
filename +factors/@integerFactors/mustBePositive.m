function mustBePositive(A)
% MUSTBEPOSITIVE - Validate that value is positive
%   This function throws an error if any value in the input
%   factors.integerFactors array is not positive.
% 
%   Syntax
%     mustBePositive(A)
% 
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
    if any(A.IsZero | A.IsNegative,"all")
        errorID = "integerFactors:validation:mustBePositive";
        message = "Value must be positive.";
        throwAsCaller(MException(errorID,message))
    end
end