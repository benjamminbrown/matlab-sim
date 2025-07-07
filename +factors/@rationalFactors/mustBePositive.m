function mustBePositive(A)
    if any((A.Numerator.IsZero & ~A.Denominator.IsZero) | A.Numerator.IsNegative~=A.Denominator.IsNegative,"all")
        errorID = "rationalFactors:mustBePositive";
        message = "Value must be positive.";
        throwAsCaller(MException(errorID,message))
    end
end