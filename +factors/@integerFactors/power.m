function C = power(A,B)
% POWER - Element-wise power
%   This function raises each element of the first operand to the
%   corresponding power in the second operand.
%
%   Syntax
%     C = A.^B
%     C = POWER(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
    arguments
        A   factors.integerFactors
        B   factors.integerFactors
    end
    if any(B.IsNegative & ~B.IsZero,"all")
        % Cast base array as a factors.rationalFactors array
        C = power(factors.rationalFactors(A),B);
    else
        % Implicitly expand singleton dimensions of input arrays
        [A,B] = utility.implicitArrayExpansion(A,B);
        if isempty(A)
            % Return empty array
            C = factors.integerFactors.empty(size(A));
        else
            % Initialize the result
            C = A;
            % Assign value of one to result where power is zero
            if any(B.IsZero,"all")
                C(B.IsZero) = ones(1,"factors.integerFactors");
            end
            % Cast the power array as an integer array
            intB = uint8(B);
            % Find where sign of result needs to be flipped
            isNegativeBaseWithNonzeroEvenPower = A.IsNegative & intB~=0 & mod(intB,2)==0;
            if any(isNegativeBaseWithNonzeroEvenPower,"all")
                % Flip sign of result where appropriate
                C.IsNegative(isNegativeBaseWithNonzeroEvenPower) = false;
            end
            % Find where any nontrivial calculation will be required
            isNontrivial = ~(A.IsZero | B.IsZero);
            if any(isNontrivial,"all")
                % Perform nontrivial calculation where appropriate
                elementIndices = find(isNontrivial);
                for elementIndex = elementIndices(:).'
                    % Multiply the prime factor exponents by the power
                    if any(A.Exponents{elementIndex}>idivide(intmax("uint8"),intB(elementIndex)))
                        % Throw error if product exceeds maximal integer
                        errorID = "integerFactors:power:exponentSumExceedsIntMax";
                        message = "Product of factor exponents and integer power exceeds the largest value of type 'uint8'. See INTMAX.";
                        error(errorID,message)
                    end
                    C.Exponents{elementIndex} = C.Exponents{elementIndex}.*intB(elementIndex);
                end
            end
        end
    end
end