function B = cast(A,varargin)
    % Perform input argument validation
    try
        narginchk(2,3)
    catch ME
        errorID = "integerFactors:validation:narginchk";
        error(errorID,ME.message)
    end
    try
        mustBeTextScalar(varargin{1})
    catch ME
        errorID = "integerFactors:validation:mustBeTextScalar";
        message = strcat("Invalid argument at position 2. ",ME.message);
        error(errorID,message)
    end
    if nargin==2
        newclass = varargin{1};
    else
        if ~strcmp(varargin{1},"like")
            errorID = "integerFactors:validation:invalidNameValueString";
            message = "With three input arguments, the second argument must be 'like'.";
            error(errorID,message)
        end
        newclass = class(varargin{2});
    end
    % Check for valid new class
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