function mustBeNonpositive(A)
    if any(~(A.Numerator.IsZero & ~A.Denominator.IsZero) & A.Numerator.IsNegative==A.Denominator.IsNegative,"all")
        errorID = "rationalFactors:mustBeNonpositive";
        message = "Value must not be positive.";
        throwAsCaller(MException(errorID,message))
    end
end