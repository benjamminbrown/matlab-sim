function mustBeInteger(A)
% MUSTBEINTEGER - Validate that value is integer
%   This function throws an error if any value in the input
%   factors.rationalFactors array is not an integer.
% 
%   Syntax
%     mustBeInteger(A)
% 
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
    errorID = "rationalFactors:validation:mustBeInteger";
    message = "Value must be integer.";
    if ~all(isfinite(A),"all")
        throwAsCaller(MException(errorID,message))
    end
    for elementIndex = 1:numel(A)
        if ~(A.Numerator.IsZero(elementIndex) | isempty(A.Denominator.Factors{elementIndex}))
            throwAsCaller(MException(errorID,message))
        end
    end
end