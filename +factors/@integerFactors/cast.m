function B = cast(A,newclass)
    arguments
        A
        newclass    {mustBeTextScalar}
    end
    floatClassnames     = ["double";...
                           "single"];
    signedClassnames    = ["int8";...
                           "int16";...
                           "int32";...
                           "int64"];
    unsignedClassnames  = ["uint8";...
                           "uint16";...
                           "uint32";...
                           "uint64"];
    isFloatClassname = any(strcmp(newclass,floatClassnames));
    isUnsignedClassname = any(strcmp(newclass,unsignedClassnames));
    isValidClassname = isFloatClassname || isUnsignedClassname || any(strcmp(newclass,signedClassnames));
    if ~isValidClassname
        errorID = "integerFactors:cast:invalidConversion";
        message = "Unsupported data conversion from 'factors.integerFactors' to '%s'.";
        error(errorID,message,newclass)
    end
    if isUnsignedClassname && any(A.IsNegative,"all")
        errorID = "integerFactors:cast:typeDoesNotSupportNegativeNumbers";
        message = "Unsigned integer types cannot represent negative numbers.";
        error(errorID,message)
    end
    if isFloatClassname
        maxInteger = flintmax(newclass);
    else
        maxInteger = intmax(newclass);
    end
    B = zeros(size(A),newclass);
    elementIndices = find(~A.IsZero(:)).';
    for elementIndex = elementIndices
        fixedQuotient = intmax("uint64");
        for factorIndex = length(A.Factors{elementIndex}):-1:1
            factor = uint64(A.Factors{elementIndex}(factorIndex));
            for count = 1:A.Exponents{elementIndex}(factorIndex)
                fixedQuotient = idivide(fixedQuotient,factor);
                if fixedQuotient==0
                    errorID = "integerFactors:cast:exceedsIntMax";
                    message = "Product of factors exceeds the largest value of type uint64. See INTMAX.";
                    error(errorID,message)
                end
            end
        end
        absInteger = prod(uint64(A.Factors{elementIndex}).^uint64(A.Exponents{elementIndex}));
        if absInteger>maxInteger
            if isFloatClassname
                errorID = "integerFactors:cast:exceedsFloatIntMax";
                message = "Product of factors exceeds the largest consecutive integer in floating-point format. See FLINTMAX.";
                error(errorID,message)
            else
                errorID = "integerFactors:cast:exceedsSpecifiedIntMax";
                message = "Product of factors exceeds the largest value of the specified integer type. See INTMAX.";
                error(errorID,message)
            end
        end
        if A.IsNegative(elementIndex)
            B(elementIndex) = -absInteger;
        else
            B(elementIndex) = absInteger;
        end
    end
end