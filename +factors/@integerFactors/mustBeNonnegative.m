function mustBeNonnegative(A)
% MUSTBENONNEGATIVE - Validate that value is nonnegative
%   This function throws an error if any value in the
%   factors.integerFactors array is negative.
% 
%   Syntax
%     mustBeNonnegative(A)
% 
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
    if any(~A.IsZero & A.IsNegative,"all")
        errorID = "integerFactors:mustBeNonnegative";
        message = "Value must be nonnegative.";
        throwAsCaller(MException(errorID,message))
    end
end