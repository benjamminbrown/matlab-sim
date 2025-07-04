function C = times(A,B)
% times - Multiplication
%   This function multiplies the corresponding elements of the input
%   arrays.
%
%   Syntax
%     C = A.*B
%     C = times(A,B)
%
%   Input Arguments
%     A - Operands
%       scalars | vectors | matrices | multidimensional arrays
%     B - Operands
%       scalars | vectors | matrices | multidimensional arrays
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
            CIndices = find(isNonzero);
            CIndices = CIndices(isNontrivial);
            for elementIndex = 1:numel(CIndices)
                % Find unique set of combined prime factors
                index = CIndices(elementIndex);
                C.Factors{index} = unique([A.Factors{index},B.Factors{index}]);
                numberOfFactors = length(C.Factors{index});
                % Sum the prime factor exponents (multiplicities)
                C.Exponents{index} = zeros([1,numberOfFactors],"uint8");
                for factorIndexC = 1:numberOfFactors
                    factorIndexA = find(A.Factors{index}==C.Factors{index}(factorIndexC));
                    factorIndexB = find(B.Factors{index}==C.Factors{index}(factorIndexC));
                    if isempty(factorIndexA)
                        C.Exponents{index}(factorIndexC) = B.Exponents{index}(factorIndexB);
                    elseif isempty(factorIndexB)
                        C.Exponents{index}(factorIndexC) = A.Exponents{index}(factorIndexA);
                    else
                        if A.Exponents{index}(factorIndexA)>intmax("uint8")-B.Exponents{index}(factorIndexB)
                            % Throw error if sum exceeds maximal integer
                            errorID = "integerFactors:times:exponentSumExceedsIntMax";
                            message = "Sum of factor exponents exceeds the largest value of type 'uint8'. See INTMAX.";
                            error(errorID,message)
                        end
                        C.Exponents{index}(factorIndexC) = uint64(A.Exponents{index}(factorIndexA))+uint64(B.Exponents{index}(factorIndexB));
                    end
                end
            end
        end
    end
end