function C = times(A,B)
% TIMES - Multiplication
%   This function multiplies the corresponding elements of the input
%   arrays.
%
%   Syntax
%     C = A.*B
%     C = TIMES(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also mtimes
    arguments
        A   factors.scaleFactors
        B   factors.scaleFactors
    end
    % Implicitly expand singleton dimensions of input arrays
    [A,B] = utility.implicitArrayExpansion(A,B);
    if isempty(A)
        % Return empty array
        C = factors.scaleFactors.empty(size(A));
    else
        % Initialize the product with a trivial array
        C = factors.scaleFactors.ones(size(A));
        % Find where any nontrivial calculation will be required
        isNontrivial = ~(cellfun(@(Factors) isempty(Factors),A.Factors) & cellfun(@(Factors) isempty(Factors),B.Factors));
        if any(isNontrivial,"all")
            % Perform nontrivial calculation where appropriate
            elementIndices = find(isNontrivial);
            for elementIndex = elementIndices(:).'
                % Find unique set of combined prime factors
                C.Factors{elementIndex} = unique([A.Factors{elementIndex},B.Factors{elementIndex}]);
                numberOfFactors = length(C.Factors{elementIndex});
                % Initialize the prime factor exponents
                C.Exponents{elementIndex} = factors.rationalFactors.zeros(1,numberOfFactors);
                for factorIndexC = 1:numberOfFactors
                    factorIndexA = find(A.Factors{elementIndex}==C.Factors{elementIndex}(factorIndexC));
                    factorIndexB = find(B.Factors{elementIndex}==C.Factors{elementIndex}(factorIndexC));
                    if isempty(factorIndexA)
                        % Prime factor comes only from B
                        C.Exponents{elementIndex}(factorIndexC) = B.Exponents{elementIndex}(factorIndexB);
                    elseif isempty(factorIndexB)
                        % Prime factor comes only from A
                        C.Exponents{elementIndex}(factorIndexC) = A.Exponents{elementIndex}(factorIndexA);
                    else
                        % Sum the prime factor exponents where appropriate
                        C.Exponents{elementIndex}(factorIndexC) = A.Exponents{elementIndex}(factorIndexA)+B.Exponents{elementIndex}(factorIndexB);
                    end
                end
                % Remove any prime factors where the exponent is zero
                isZeroExponent = C.Exponents{elementIndex}.Numerator.IsZero;
                C.Factors{elementIndex}(isZeroExponent) = [];
                C.Exponents{elementIndex}(isZeroExponent) = [];
            end
        end
    end
end