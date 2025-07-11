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
        A   factors.integerFactors
        B   factors.integerFactors
    end
    % Implicitly expand singleton dimensions of input arrays
    [A,B] = utility.implicitArrayExpansion(A,B);
    if isempty(A)
        % Return empty array
        C = factors.integerFactors.empty(size(A));
    else
        % Initialize the product with a trivial array
        C = factors.integerFactors.zeros(size(A));
        % Product is zero where either operand is zero
        C.IsZero = A.IsZero | B.IsZero;
        % Product is negative where operands have opposite signs
        C.IsNegative = A.IsNegative~=B.IsNegative;
        % Find where any nontrivial calculation will be required
        isNonzero = ~C.IsZero;
        isNontrivial = ~(cellfun(@(Factors) isempty(Factors),A.Factors(isNonzero)) & cellfun(@(Factors) isempty(Factors),B.Factors(isNonzero)));
        if any(isNontrivial,"all")
            % Perform nontrivial calculation where appropriate
            elementIndices = find(isNonzero);
            elementIndices = elementIndices(isNontrivial);
            for elementIndex = elementIndices(:).'
                % Find unique set of combined prime factors
                C.Factors{elementIndex} = unique([A.Factors{elementIndex},B.Factors{elementIndex}]);
                numberOfFactors = length(C.Factors{elementIndex});
                % Initialize the prime factor exponents (multiplicities)
                C.Exponents{elementIndex} = zeros([1,numberOfFactors],"uint8");
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
                        if A.Exponents{elementIndex}(factorIndexA)>intmax("uint8")-B.Exponents{elementIndex}(factorIndexB)
                            % Throw error if sum exceeds maximal integer
                            errorID = "integerFactors:times:exponentSumExceedsIntMax";
                            message = "Sum of factor exponents exceeds the largest value of type 'uint8'. See INTMAX.";
                            error(errorID,message)
                        end
                        C.Exponents{elementIndex}(factorIndexC) = uint64(A.Exponents{elementIndex}(factorIndexA))+uint64(B.Exponents{elementIndex}(factorIndexB));
                    end
                end
            end
        end
    end
end