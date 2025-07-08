classdef (InferiorClasses={?factors.integerFactors,?factors.rationalFactors}) scaleFactors < matlab.mixin.indexing.RedefinesParen
    properties (SetAccess=private)
        Factors     cell    = {uint64.empty(1,0)};
        Exponents   cell    = {factors.rationalFactors.empty(1,0)};
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
        B = ctranspose(A)
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
        Y = abs(X)
        Y = sign(X)
        Zc = conj(Z)
        C = times(A,B) % TODO
        C = mtimes(A,B) % TODO
        C = rdivide(A,B) % TODO
        C = mrdivide(B,A) % TODO
        C = ldivide(B,A) % TODO
        C = mldivide(A,B) % TODO
        C = power(A,B) % TODO
        C = mpower(A,B) % TODO
        Y = nthroot(X,N) % TODO
        B = sqrt(X) % TODO
        B = cast(A,newclass) % TODO
        B = double(A) % TODO
        B = single(A) % TODO
    end
    %% STATIC METHODS
    methods (Static)
        obj = empty(varargin)
        obj = ones(varargin)
    end
    %% HIDDEN METHODS
    methods (Hidden)
        mustBePositive(A)
        mustBeNonpositive(A)
        mustBeNonnegative(A)
        mustBeNegative(A)
        mustBeNonzero(A)
        mustBeInteger(A) % TODO
    end
end
%% VALIDATION FUNCTIONS
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