classdef (InferiorClasses={?factors.integerFactors,?factors.rationalFactors}) scaleFactors < matlab.mixin.indexing.RedefinesParen
    properties (SetAccess=private)
        Factors     {mustBeValidFactorsProperty}    = {uint64.empty(1,0)};
        Exponents   {mustBeValidExponentsProperty}  = factors.rationalFactors.empty(1,0);
    end
    %% CONSTRUCTOR
    methods
        function obj = scaleFactors(varargin)
            arguments (Repeating)
                varargin    {mustBeValidConstructorArgument}
            end
            switch nargin
                case 0
                    errorID = "scaleFactors:notEnoughInputArguments";
                    message = "Not enough input arguments.";
                    error(errorID,message)
                case 1 % TODO
                otherwise
                    errorID = "scaleFactors:tooManyInputArguments";
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
        TF = eq(A,B) % TODO
        TF = ne(A,B) % TODO
        TF = gt(A,B) % TODO
        TF = ge(A,B) % TODO
        TF = lt(A,B) % TODO
        TF = le(A,B) % TODO
        X = abs(X)
        Y = sign(X)
        C = times(A,B) % TODO
        C = rdivide(A,B) % TODO
        C = ldivide(A,B) % TODO
        C = power(A,B) % TODO
        C = mpower(A,B)
        Y = nthroot(X,N) % TODO
        B = cast(A,newclass) % TODO
        B = double(A) % TODO
        B = single(A) % TODO
    end
    %% STATIC METHODS
    methods (Static)
        function obj = empty(varargin)
            obj = factors.scaleFactors(uint8.empty(varargin{:}));
        end
        function obj = ones(varargin)
            obj = factors.scaleFactors(ones(varargin{:},"uint8"));
        end
    end
    %% HIDDEN METHODS
    methods (Hidden)
        function mustBePositive(~)
        end
        function mustBeNonpositive(~)
            errorID = "scaleFactors:mustBeNonpositive";
            message = "Value must not be positive.";
            throwAsCaller(MException(errorID,message));
        end
        function mustBeNonnegative(~)
        end
        function mustBeNegative(~)
            errorID = "scaleFactors:mustBeNegative";
            message = "Value must be negative.";
            throwAsCaller(MException(errorID,message));
        end
        function mustBeNonzero(~)
        end
        function mustBeInteger(A) % TODO
            errorID = "scaleFactors:mustBeInteger";
            message = "Value must be integer.";
            throwAsCaller(MException(errorID,message));
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
        errorID = "scaleFactors:mustBeValidFactorsProperty";
        message = "Factors property must be a cell array of finite positive row vectors of type 'factors.rationalFactors'.";
        throwAsCaller(MException(errorID,message))
    end
end
function mustBeValidExponentsProperty(prop)
    try
        mustBeA(prop,"cell")
        for elementIndex = 1:numel(prop)
            mustBeA(prop{elementIndex},"factors.rationalFactors")
            mustBeRow(prop{elementIndex})
            mustBeFinite(prop{elementIndex})
        end
    catch
        errorID = "scaleFactors:mustBeValidExponentsProperty";
        message = "Exponents property must be a cell array of finite row vectors of type 'factors.rationalFactors'.";
        throwAsCaller(MException(errorID,message))
    end
end
function mustBeValidConstructorArgument(A)
    try
        if ~isa(A,["factors.scaleFactors","factors.rationalFactors"])
            mustBeInteger(A)
        end
    catch
        errorID = "scaleFactors:mustBeValidConstructorArgument";
        message = "Value must be either an integer or one of these types: 'factors.scaleFactors' or 'factors.rationalFactors'.";
        throwAsCaller(MException(errorID,message))
    end
end