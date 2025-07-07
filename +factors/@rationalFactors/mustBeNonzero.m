function mustBeNonzero(A)
    if any((A.Numerator.IsZero & ~A.Denominator.IsZero),"all")
        errorID = "rationalFactors:mustBeNonzero";
        message = "Value must not be zero.";
        throwAsCaller(MException(errorID,message))
    end
end