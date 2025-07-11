classdef integerFactors < matlab.mixin.indexing.RedefinesParen
% FACTORS.INTEGERFACTORS - Integer prime factor decomposition class
%   This class automatically stores the prime factorization for any
%   supplied integer array with absolute values less than 2^64-1. It can be
%   used to symbolically handle any numeric operations on the stored
%   integers, including unary positive and negative, absolute value,
%   addition and subtraction, multiplication, and exponentiation.
% 
%   Creation
%     Syntax
%       obj = factors.integerFactors(I)
% 
%     Input Arguments
%       I - Integer array
%         scalar | vector | matrix | multidimensional array
%
%   See also cast, factor, factors.rationalFactors, factors.scaleFactors
    properties (SetAccess=private)
        IsZero      logical = true                  % Logical value indicating whether the integer is equal to zero.
        IsNegative  logical = false                 % Logical value indicating whether the integer is negative.
        Factors     cell    = {uint64.empty(1,0)}   % Row vector of the prime factors.
        Exponents   cell    = {uint8.empty(1,0)}    % Row vector of the prime factor exponents (multiplicity).
    end
    %% CONSTRUCTOR
    methods
        function obj = integerFactors(varargin)
            arguments (Repeating)
                varargin    {mustBeNumericOrLogical,mustBeInteger}
            end
            narginchk(1,1)
            if isa(varargin{1},"factors.integerFactors")
                % Copy object array
                obj = varargin{1};
            elseif isa(varargin{1},"factors.rationalFactors")
                % Copy the numerator property of object array
                obj = varargin{1}.Numerator;
                % Account for the numerator and denominator signs
                obj.IsNegative = varargin{1}.Numerator.IsNegative~=varargin{1}.Denominator.IsNegative;
            else
                % Initialize the object array
                obj = repmat(obj,size(varargin{1}));
                if ~isempty(obj)
                    isZero = varargin{1}==0;
                    if any(isZero,"all")
                        % Account for any -0 integers
                        obj.IsNegative(isZero) = 1./varargin{1}(isZero)==-inf;
                    end
                    isNonzero = ~isZero;
                    if any(isNonzero,"all")
                        % Account for any nonzero integers
                        obj.IsZero(isNonzero) = false;
                        obj.IsNegative(isNonzero) = varargin{1}(isNonzero)<0;
                        isNontrivial = abs(varargin{1}(isNonzero))~=1;
                        if any(isNontrivial,"all")
                            % Account for any nontrivial integers
                            objIndices = find(isNonzero);
                            objIndices = objIndices(isNontrivial);
                            for elementIndex = 1:numel(objIndices)
                                % Decompose into prime factors
                                factors = factor(uint64(abs(varargin{1}(objIndices(elementIndex)))));
                                obj.Factors{objIndices(elementIndex)} = unique(factors);
                                numberOfFactors = length(obj.Factors{objIndices(elementIndex)});
                                obj.Exponents{objIndices(elementIndex)} = zeros(1,numberOfFactors,"uint8");
                                for factorIndex = 1:numberOfFactors
                                    obj.Exponents{objIndices(elementIndex)}(factorIndex) = sum(factors==obj.Factors{objIndices(elementIndex)}(factorIndex));
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    %% PROTECTED METHODS
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
        varargout = commonFactors(A,B)
        B = cast(A,varargin)
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
        obj = empty(varargin)
        obj = zeros(varargin)
        obj = ones(varargin)
    end
    %% HIDDEN METHODS
    methods (Hidden)
        mustBePositive(A)
        mustBeNonpositive(A)
        mustBeNonnegative(A)
        mustBeNegative(A)
        mustBeNonzero(A)
        mustBeInteger(~)
    end
end