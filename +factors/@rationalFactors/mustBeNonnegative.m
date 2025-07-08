function mustBeNonnegative(A)
% MUSTBENONNEGATIVE - Validate that value is nonnegative
%   This function throws an error if any value in the input
%   factors.rationalFactors array is negative.
% 
%   Syntax
%     mustBeNonnegative(A)
% 
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
    if any(~(A.Numerator.IsZero & ~A.Denominator.IsZero) & A.Numerator.IsNegative~=A.Denominator.IsNegative,"all")
        errorID = "rationalFactors:validation:mustBeNonnegative";
        message = "Value must be nonnegative.";
        throwAsCaller(MException(errorID,message))
    end
end