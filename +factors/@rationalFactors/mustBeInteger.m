function mustBeInteger(A)
    errorID = "rationalFactors:mustBeInteger";
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