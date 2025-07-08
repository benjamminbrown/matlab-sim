function mustBeNegative(A)
% MUSTBENEGATIVE - Validate that value is negative
%   This function throws an error if any value in the input
%   factors.integerFactors array is not negative.
% 
%   Syntax
%     mustBeNegative(A)
% 
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
    if any(A.IsZero | ~A.IsNegative,"all")
        errorID = "integerFactors:validation:mustBeNegative";
        message = "Value must be negative.";
        throwAsCaller(MException(errorID,message))
    end
end