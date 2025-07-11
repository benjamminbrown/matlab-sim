function B = cast(A,varargin)
% CAST - Convert variable to different data type
%   This function returns the scales in the factors.scaleFactors array
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
%       "single" | "double"
%     p - Prototype
%       scalar | vector | matrix | multidimensional array
%
%   See also class

    % Perform input argument validation
    try
        narginchk(2,3)
    catch ME
        errorID = "scaleFactors:validation:narginchk";
        error(errorID,ME.message)
    end
    try
        mustBeTextScalar(varargin{1})
    catch ME
        errorID = "scaleFactors:validation:mustBeTextScalar";
        message = strcat("Invalid argument at position 2. ",ME.message);
        error(errorID,message)
    end
    if nargin==2
        newclass = varargin{1};
    else
        if ~strcmp(varargin{1},"like")
            errorID = "scaleFactors:validation:invalidNameValueString";
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
        errorID = "scaleFactors:cast:invalidConversion";
        message = "Unsupported data conversion from 'factors.scaleFactors' to '%s'.";
        error(errorID,message,newclass)
    end
    % Initialize the output array
    B = ones(size(A),newclass);
    % Find where nontrivial calculation will be required
    isNontrivial = ~cellfun(@(Factors) isempty(Factors),A.Factors);
    if any(isNontrivial,"all")
        % Perform nontrivial calculation of value where appropriate
        elementIndices = find(isNontrivial);
        for elementIndex = elementIndices(:).'
            % Assign value to output array
            B(elementIndex) = prod(nthroot(power(double(A.Factors{elementIndex}),double(A.Exponents{elementIndex}.Numerator)),double(A.Exponents{elementIndex}.Denominator)));
        end
    end
end