function mustBeNonpositive(~)
% MUSTBENONPOSITIVE - Validate that value is nonpositive
%   This function always throws an error for an input factors.scaleFactors
%   array.
% 
%   Syntax
%     mustBeNonpositive(A)
% 
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
    errorID = "scaleFactors:validation:mustBeNonpositive";
    message = "Value must not be positive.";
    throwAsCaller(MException(errorID,message));
end