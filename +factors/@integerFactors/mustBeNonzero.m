function mustBeNonzero(A)
% MUSTBENONZERO - Validate that value is nonzero
%   This function throws an error if any value in the
%   factors.integerFactors array is zero.
% 
%   Syntax
%     mustBeNonzero(A)
% 
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
    if any(A.IsZero,"all")
        errorID = "integerFactors:validation:mustBeNonzero";
        message = "Value must not be zero.";
        throwAsCaller(MException(errorID,message))
    end
end