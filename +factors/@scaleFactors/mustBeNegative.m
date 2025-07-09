function mustBeNegative(~)
% MUSTBENEGATIVE - Validate that value is negative
%   This function always throws an error for an input factors.scaleFactors
%   array.
% 
%   Syntax
%     mustBeNegative(A)
% 
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
    errorID = "scaleFactors:mustBeNegative";
    message = "Value must be negative.";
    throwAsCaller(MException(errorID,message));
end