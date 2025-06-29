function B = cast(A,newclass)
    arguments
        A
        newclass    {mustBeTextScalar}
    end
    floatClassnames     = ["double";...
                           "single"];
    isValidClassname = any(strcmp(newclass,floatClassnames));
    if ~isValidClassname
        errorID = "rationalFactors:cast:invalidConversion";
        message = "Unsupported data conversion from 'factors.rationalFactors' to '%s'.";
        error(errorID,message,newclass)
    end
    maxInteger = flintmax(newclass);
    B = zeros(size(A),newclass);
    notWarned = true;
    elementIndices = find(~A.Numerator.IsZero(:) | A.Denominator.IsZero(:)).';
    for elementIndex = elementIndices
        absNumerator = uint64(abs(A.Numerator(elementIndex)));
        absDenominator = uint64(abs(A.Denominator(elementIndex)));
        if notWarned && any([absNumerator,absDenominator]>maxInteger)
            warnID = "rationalFactors:cast:exceedsFloatIntMax";
            message = "Integer numerator or denominator exceeds the largest consecutive integer in floating-point format. See FLINTMAX.";
            warning(warnID,message)
            notWarned = false;
        end
        if A.Numerator.IsNegative(elementIndex)~=A.Denominator.IsNegative(elementIndex)
            B(elementIndex) = -double(absNumerator)/double(absDenominator);
        else
            B(elementIndex) = double(absNumerator)/double(absDenominator);
        end
    end
end