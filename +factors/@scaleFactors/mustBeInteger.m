function mustBeInteger(A)
% MUSTBEINTEGER - Validate that value is integer
%   This function throws an error if any value in the input
%   factors.scaleFactors array is not an integer.
% 
%   Syntax
%     mustBeInteger(A)
% 
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
    errorID = "scaleFactors:validation:mustBeInteger";
    message = "Value must be integer.";
    for elementIndex = 1:numel(A)
        try
            mustBeNonnegative(A.Exponents{elementIndex})
            mustBeInteger(A.Exponents{elementIndex})
        catch
            throwAsCaller(MException(errorID,message))
        end
    end
end