function mustBeNegative(A)
% MUSTBENEGATIVE - Validate that value is negative
%   This function throws an error if any value in the input
%   factors.rationalFactors array is not negative.
% 
%   Syntax
%     mustBeNegative(A)
% 
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
    if any((A.Numerator.IsZero & ~A.Denominator.IsZero) | A.Numerator.IsNegative==A.Denominator.IsNegative,"all")
        errorID = "rationalFactors:mustBeNegative";
        message = "Value must be negative.";
        throwAsCaller(MException(errorID,message))
    end
end