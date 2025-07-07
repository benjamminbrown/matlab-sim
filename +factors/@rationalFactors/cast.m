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
        errorID = "rationalFactors:validation:narginchk";
        error(errorID,ME.message)
    end
    try
        mustBeTextScalar(varargin{1})
    catch ME
        errorID = "rationalFactors:validation:mustBeTextScalar";
        message = strcat("Invalid argument at position 2. ",ME.message);
        error(errorID,message)
    end
    if nargin==2
        newclass = varargin{1};
    else
        if ~strcmp(varargin{1},"like")
            errorID = "rationalFactors:validation:invalidNameValueString";
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
    % Initialize the output array
    B = zeros(size(A),newclass);
    % Find the maximum integer for lossless conversion
    maxInteger = flintmax(newclass);
    % Check for nonzero elements
    isNonzero = ~A.Numerator.IsZero | A.Denominator.IsZero;
    if any(isNonzero,"all")
        notWarned = true;
        elementIndices = find(isNonzero);
        for elementIndex = elementIndices(:).'
            % Check for lossless conversion to new class
            absNumerator = uint64(abs(A.Numerator(elementIndex)));
            absDenominator = uint64(abs(A.Denominator(elementIndex)));
            if notWarned && any([absNumerator,absDenominator]>maxInteger)
                % Throw warning if inaccurate conversion
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
end