function mustBeNonpositive(A)
% MUSTBENONPOSITIVE - Validate that value is nonpositive
%   This function throws an error if any value in the
%   factors.integerFactors array is positive.
% 
%   Syntax
%     mustBeNonpositive(A)
% 
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
    if any(~A.IsZero & ~A.IsNegative,"all")
        errorID = "integerFactors:mustBeNonpositive";
        message = "Value must not be positive.";
        throwAsCaller(MException(errorID,message))
    end
end