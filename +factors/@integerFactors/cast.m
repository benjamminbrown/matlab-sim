function B = cast(A,varargin)
% CAST - Convert variable to different data type
%   This function returns the integers in the factors.integerFactors array
%   converted to the specified data type (class).
%
%   Syntax
%     B = cast(A,newclass)
%     B = cast(A,"like",p)
%
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
%     newclass - New class
%       "single" | "double" | "int8" | "int16" | "int32" | "int64" |
%       "uint8" | "uint16" | "uint32" | "uint64"
%     p - Prototype
%       scalar | vector | matrix | multidimensional array
%
%   See also class

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
    if isUnsignedClassname
        try
            mustBeNonnegative(A)
        catch
            errorID = "integerFactors:cast:typeDoesNotSupportNegativeNumbers";
            message = "Unsigned integer types cannot represent negative numbers.";
            error(errorID,message)
        end
    end
    % Initialize the output array
    B = zeros(size(A),newclass);
    % Find the maximum integer for lossless conversion
    if isFloatClassname
        maxInteger = flintmax(newclass);
    else
        maxInteger = intmax(newclass);
    end
    % Check for nonzero elements
    isNonzero = ~A.IsZero;
    if any(isNonzero,"all")
        elementIndices = find(~A.IsZero(:));
        for elementIndex = elementIndices(:).'
            if ~isempty(A.Factors{elementIndex})
                % Check for lossless conversion to type "uint64"
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
            end
            % Perform conversion of absolute value to type "uint64"
            absInteger = prod(uint64(A.Factors{elementIndex}).^uint64(A.Exponents{elementIndex}));
            % Check for lossless conversion to requested type
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
            % Assign value to output array
            if A.IsNegative(elementIndex)
                B(elementIndex) = -absInteger;
            else
                B(elementIndex) = absInteger;
            end
        end
    end
end