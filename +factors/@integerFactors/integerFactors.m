classdef integerFactors < matlab.mixin.indexing.RedefinesParen
% FACTORS.INTEGERFACTORS - Integer prime factorization class
%   This class automatically stores the prime factorization for any
%   supplied integer array with absolute values less than 2^64-1. It can be
%   used to symbolically handle any numeric operations on the stored
%   integers, including unary positive and negative, absolute value,
%   addition and subtraction, multiplication, and exponentiation.

    properties (SetAccess=private)
        IsZero          {mustBeA(IsZero,"logical")}         = true
        IsNegative      {mustBeA(IsNegative,"logical")}     = false
        Factors         {mustBeValidFactorsProperty}        = {uint64.empty(1,0)}
        Exponents       {mustBeValidExponentsProperty}      = {uint8.empty(1,0)}
    end
    %% CONSTRUCTOR
    methods
        function obj = integerFactors(varargin)
            arguments (Repeating)
                varargin    {mustBeInteger}
            end
            switch nargin
                case 0
                    errorID = "integerFactors:notEnoughInputArguments";
                    message = "Not enough input arguments.";
                    error(errorID,message)
                case 1
                    if isa(varargin{1},"factors.integerFactors")
                        % Copy object array
                        obj = varargin{1};
                    elseif isa(varargin{1},"factors.rationalFactors")
                        % Copy Numerator property of object array
                        obj = varargin{1}.Numerator;
                        obj.IsNegative = varargin{1}.Numerator.IsNegative~=varargin{1}.Denominator.IsNegative;
                    else
                        % Compute prime factor decomposition
                        obj = repmat(obj,size(varargin{1}));
                        for elementIndex = 1:numel(varargin{1})
                            if varargin{1}(elementIndex)==0
                                if 1/varargin{1}(elementIndex)==-inf
                                    obj.IsNegative(elementIndex) = true;
                                end
                            else
                                obj.IsZero(elementIndex) = false;
                                if varargin{1}(elementIndex)<0
                                    obj.IsNegative(elementIndex) = true;
                                end
                                if abs(varargin{1}(elementIndex))~=1
                                    factors = factor(uint64(abs(varargin{1}(elementIndex))));
                                    obj.Factors{elementIndex} = unique(factors);
                                    numberOfFactors = length(obj.Factors{elementIndex});
                                    obj.Exponents{elementIndex} = zeros(1,numberOfFactors,"uint8");
                                    for factorIndex = 1:numberOfFactors
                                        obj.Exponents{elementIndex}(factorIndex) = sum(factors==obj.Factors{elementIndex}(factorIndex));
                                    end
                                end
                            end
                        end
                    end
                otherwise
                    errorID = "integerFactors:tooManyInputArguments";
                    message = "Too many input arguments.";
                    error(errorID,message)
            end
        end
    end
    %% PRIVATE METHODS
    methods (Access=protected)
        varargout = parenReference(obj,indexOp)
        obj = parenAssign(obj,indexOp,arg)
        n = parenListLength(obj,indexOp,indexContext)
        obj = parenDelete(obj,indexOp)
    end
    %% PUBLIC METHODS
    methods (Access=public)
        varargout = size(obj,varargin)
        obj = cat(dim,varargin)
        B = permute(A,dimorder)
        B = transpose(A)
        B = reshape(A,varargin)
        TF = isfinite(A)
        TF = isinf(A)
        TF = isnan(A)
        TF = isreal(A)
        TF = isnumeric(A)
        TF = eq(A,B)
        TF = ne(A,B)
        TF = gt(A,B)
        TF = ge(A,B)
        TF = lt(A,B)
        TF = le(A,B)
        X = floor(X)
        X = ceil(X)
        X = fix(X)
        X = round(X)
        X = uplus(X)
        Y = uminus(X)
        Y = abs(X)
        Y = sign(X)
        C = plus(A,B)
        C = minus(A,B)
        C = times(A,B)
        C = rdivide(A,B)
        C = ldivide(A,B)
        R = rem(A,B)
        B = mod(A,M)
        C = power(A,B)
        C = mpower(A,B)
        varargout = commonFactors(A,B)
        B = cast(A,newclass)
        B = double(A)
        B = single(A)
        B = int8(A)
        B = int16(A)
        B = int32(A)
        B = int64(A)
        B = uint8(A)
        B = uint16(A)
        B = uint32(A)
        B = uint64(A)
    end
    %% STATIC METHODS
    methods (Static)
        function obj = empty(varargin)
            obj = factors.integerFactors(uint8.empty(varargin{:}));
        end
        function obj = zeros(varargin)
            obj = factors.integerFactors(zeros(varargin{:},"uint8"));
        end
        function obj = ones(varargin)
            obj = factors.integerFactors(ones(varargin{:},"uint8"));
        end
    end
    %% HIDDEN METHODS
    methods (Hidden)
        function mustBePositive(A)
            if any(A.IsZero | A.IsNegative,"all")
                errorID = "integerFactors:mustBePositive";
                message = "Value must be positive.";
                throwAsCaller(MException(errorID,message))
            end
        end
        function mustBeNonpositive(A)
            if any(~A.IsZero & ~A.IsNegative,"all")
                errorID = "integerFactors:mustBeNonpositive";
                message = "Value must not be positive.";
                throwAsCaller(MException(errorID,message))
            end
        end
        function mustBeNonnegative(A)
            if any(~A.IsZero & A.IsNegative,"all")
                errorID = "integerFactors:mustBeNonnegative";
                message = "Value must be nonnegative.";
                throwAsCaller(MException(errorID,message))
            end
        end
        function mustBeNegative(A)
            if any(A.IsZero | ~A.IsNegative,"all")
                errorID = "integerFactors:mustBeNegative";
                message = "Value must be negative.";
                throwAsCaller(MException(errorID,message))
            end
        end
        function mustBeNonzero(A)
            if any(A.IsZero,"all")
                errorID = "integerFactors:mustBeNonzero";
                message = "Value must not be zero.";
                throwAsCaller(MException(errorID,message))
            end
        end
        function mustBeInteger(~)
        end
    end
end
%% VALIDATION FUNCTIONS
function mustBeValidFactorsProperty(prop)
    try
        mustBeA(prop,"cell")
        for elementIndex = 1:numel(prop)
            mustBeA(prop{elementIndex},"uint64")
            mustBeRow(prop{elementIndex})
        end
    catch
        errorID = "integerFactors:mustBeValidFactorsProperty";
        message = "Factors property must be a cell array of row vectors of type 'uint64'.";
        throwAsCaller(MException(errorID,message))
    end
end
function mustBeValidExponentsProperty(prop)
    try
        mustBeA(prop,"cell")
        for elementIndex = 1:numel(prop)
            mustBeA(prop{elementIndex},"uint8")
            mustBeRow(prop{elementIndex})
        end
    catch
        errorID = "integerFactors:mustBeValidExponentsProperty";
        message = "Exponents property must be a cell array of row vectors of type 'uint8'.";
        throwAsCaller(MException(errorID,message))
    end
end