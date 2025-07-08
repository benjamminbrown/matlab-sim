function mustBeNonpositive(A)
% MUSTBENONPOSITIVE - Validate that value is nonpositive
%   This function throws an error if any value in the input
%   factors.rationalFactors array is positive.
% 
%   Syntax
%     mustBeNonpositive(A)
% 
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
    if any(~(A.Numerator.IsZero & ~A.Denominator.IsZero) & A.Numerator.IsNegative==A.Denominator.IsNegative,"all")
        errorID = "rationalFactors:mustBeNonpositive";
        message = "Value must not be positive.";
        throwAsCaller(MException(errorID,message))
    end
end