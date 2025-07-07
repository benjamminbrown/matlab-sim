function mustBeNegative(A)
    if any((A.Numerator.IsZero & ~A.Denominator.IsZero) | A.Numerator.IsNegative==A.Denominator.IsNegative,"all")
        errorID = "rationalFactors:mustBeNegative";
        message = "Value must be negative.";
        throwAsCaller(MException(errorID,message))
    end
end