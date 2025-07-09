classdef (InferiorClasses={?factors.integerFactors}) rationalFactors < matlab.mixin.indexing.RedefinesParen
% FACTORS.RATIONALFACTORS - Rational prime factorization class
%   This class automatically stores the prime factorization for the integer
%   numerator and denominator of a rational number. It makes use of the
%   factors.integerFactors class to factorize the integers. It can be used
%   to symbolically handle any numeric operations on the stored rational
%   numbers, including unary positive and negative, absolute value,
%   addition and subtraction, multiplication, and exponentiation.
% 
%   Creation
%     Syntax
%       obj = factors.rationalFactors(A)
%       obj = factors.rationalFactors(N,D)
% 
%     Input Arguments
%       A - Integer or rational array
%         scalar | vector | matrix | multidimensional array
%       N - Integer or rational numerator array
%         scalar | vector | matrix | multidimensional array
%       D - Integer or rational denominator array
%         scalar | vector | matrix | multidimensional array
%
%   See also cast, factor, factors.integerFactors, factors.scaleFactors
    properties (SetAccess=private)
        Numerator   factors.integerFactors  = factors.integerFactors.zeros(1);  % Prime factorization of the integer numerator
        Denominator factors.integerFactors  = factors.integerFactors.ones(1);   % Prime factorization of the integer denominator
    end
    %% CONSTRUCTOR
    methods
        function obj = rationalFactors(varargin)
            arguments (Repeating)
                varargin    {mustBeValidConstructorArgument}
            end
            narginchk(1,2)
            if nargin==1
                if isa(varargin{1},"factors.rationalFactors")
                    % Copy object array
                    obj = varargin{1};
                else
                    % Assign integer array to numerator property
                    obj.Numerator = factors.integerFactors(varargin{1});
                    % Match sizes of numerator and denominator arrays
                    obj.Denominator = repmat(obj.Denominator,size(obj.Numerator));
                end
            else
                % Construct rationalFactors arrays and divide
                obj = factors.rationalFactors(varargin{1})./factors.rationalFactors(varargin{2});
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
        Y = floor(X)
        Y = ceil(X)
        Y = fix(X)
        Y = round(X)
        Y = abs(X)
        Y = sign(X)
        Zc = conj(Z)
        C = uplus(A)
        C = uminus(A)
        C = plus(A,B)
        C = minus(A,B)
        C = times(A,B)
        C = mtimes(A,B)
        C = rdivide(A,B)
        C = mrdivide(B,A)
        C = ldivide(B,A)
        C = mldivide(A,B)
        C = power(A,B)
        C = mpower(A,B)
        R = rem(A,B)
        B = mod(A,M)
        B = cast(A,varargin)
        B = double(A)
        B = single(A)
    end
    %% STATIC METHODS
    methods (Static)
        obj = empty(varargin)
        obj = zeros(varargin)
        obj = ones(varargin)
        obj = Inf(varargin)
        obj = NaN(varargin)
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
        if ~isa(A,"factors.rationalFactors")
            mustBeInteger(A)
        end
    catch
        errorID = "rationalFactors:validation:mustBeValidConstructorArgument";
        message = "Value must be either an integer or of type 'factors.rationalFactors'.";
        throwAsCaller(MException(errorID,message))
    end
end
