function mustBeNonnegative(A)
    if any(~(A.Numerator.IsZero & ~A.Denominator.IsZero) & A.Numerator.IsNegative~=A.Denominator.IsNegative,"all")
        errorID = "rationalFactors:mustBeNonnegative";
        message = "Value must be nonnegative.";
        throwAsCaller(MException(errorID,message))
    end
end