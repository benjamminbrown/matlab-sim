classdef (InferiorClasses={?factors.integerFactors,?factors.rationalFactors}) scaleFactors < matlab.mixin.indexing.RedefinesParen
% FACTORS.SCALEFACTORS - Scale prime factor decomposition class
%   This class is designed for the symbolic treatment of numeric scales,
%   represented as a product of positive rational numbers raised to
%   positive rational powers. It makes use of the classes
%   factors.integerFactors and factors.rationalFactors to decompose these
%   rational numbers into their prime factors. It can be used to
%   symbolically handle numeric operations on the stored scales, such as
%   multiplication, division, and exponentiation.
% 
%   Creation
%     Syntax
%       obj = factors.scaleFactors(S)
% 
%     Input Arguments
%       S - Integer or rational array
%         scalar | vector | matrix | multidimensional array
%
%   See also cast, factor, factors.integerFactors, factors.rationalFactors
    properties (SetAccess=private)
        Factors     cell    = {uint64.empty(1,0)};                  % Row vector of the prime factors.
        Exponents   cell    = {factors.rationalFactors.empty(1,0)}; % Row vector of the prime factor rational exponents.
    end
    %% CONSTRUCTOR
    methods
        function obj = scaleFactors(varargin)
            arguments (Repeating)
                varargin    {mustBeValidConstructorArgument}
            end
            narginchk(1,1)
            if isa(varargin{1},"factors.scaleFactors")
                % Copy object array
                obj = varargin{1};
            elseif isa(varargin{1},"factors.rationalFactors")
                % Initialize the object array
                obj = repmat(obj,size(varargin{1}));
                for elementIndex = 1:numel(obj)
                    if ~(isempty(varargin{1}.Numerator.Factors{elementIndex}) && isempty(varargin{1}.Denominator.Factors{elementIndex}))
                        % Extract prime factors and exponents
                        [obj.Factors{elementIndex},sortIndices] = sort([varargin{1}.Numerator.Factors{elementIndex},varargin{1}.Denominator.Factors{elementIndex}]);
                        exponents = [int16(varargin{1}.Numerator.Exponents{elementIndex}),-int16(varargin{1}.Denominator.Exponents{elementIndex})];
                        obj.Exponents{elementIndex} = factors.rationalFactors(exponents(sortIndices));
                    end
                end
            else
                if ~isa(varargin{1},"factors.integerFactors")
                    % Perform prime factor decomposition
                    varargin{1} = factors.integerFactors(varargin{1});
                end
                % Initialize the object array
                obj = repmat(obj,size(varargin{1}));
                for elementIndex = 1:numel(obj)
                    if ~isempty(varargin{1}.Factors{elementIndex})
                        % Extract prime factors and exponents
                        obj.Factors{elementIndex} = varargin{1}.Factors{elementIndex};
                        obj.Exponents{elementIndex} = factors.rationalFactors(varargin{1}.Exponents{elementIndex});
                    end
                end
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
        TF = eq(A,B)
        TF = ne(A,B)
        TF = gt(A,B)
        TF = ge(A,B)
        TF = lt(A,B)
        TF = le(A,B)
        Y = abs(X)
        Y = sign(X)
        Zc = conj(Z)
        C = times(A,B)
        C = mtimes(A,B)
        C = rdivide(A,B)
        C = mrdivide(B,A)
        C = ldivide(B,A)
        C = mldivide(A,B)
        C = power(A,B)
        C = mpower(A,B)
        Y = nthroot(X,N)
        B = sqrt(X)
        B = cast(A,newclass)
        B = double(A)
        B = single(A)
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
        mustBeInteger(A)
    end
end
%% VALIDATION FUNCTIONS
function mustBeValidConstructorArgument(A)
    try
        mustBePositive(A)
        if ~any(strcmp(class(A),["factors.scaleFactors","factors.rationalFactors"]))
            mustBeInteger(A)
        end
    catch
        errorID = "scaleFactors:validation:mustBeValidConstructorArgument";
        message = "Value must be positive and either an integer or one of these types: 'factors.scaleFactors' or 'factors.rationalFactors'.";
        throwAsCaller(MException(errorID,message))
    end
end