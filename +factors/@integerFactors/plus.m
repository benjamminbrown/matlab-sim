function C = plus(A,B)
% PLUS - Add numbers
%   This function adds the corresponding elements of the input arrays.
%
%   Syntax
%     C = A + B
%     C = PLUS(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also minus, uplus
    arguments
        A   factors.integerFactors
        B   factors.integerFactors
    end
    % Extract any common factors and perform addition on reduced arrays
    [R,Ar,Br] = commonFactors(A,B);
    % Initialize the sum with a trivial array
    isAr = ~Ar.IsZero & Br.IsZero;
    isBr = Ar.IsZero & ~Br.IsZero;
    isZero = Ar==-Br;
    [~,maxIndex] = max([sum(isAr(:)),sum(isBr(:)),sum(isZero)]);
    if maxIndex<3
        if maxIndex==1
            Cr = Ar;
            Cr(isBr) = Br(isBr);
        else
            Cr = Br;
            Cr(isAr) = Ar(isAr);
        end
        Cr(isZero) = factors.integerFactors.zeros(size(Cr(isZero)));
    else
        Cr = factors.integerFactors.zeros(size(Ar));
        Cr(isAr) = Ar(isAr);
        Cr(isBr) = Br(isBr);
    end
    % Find where any nontrivial calculation will be required
    isNontrivial = ~Ar.IsZero & ~Br.IsZero & Ar~=-Br;
    if any(isNontrivial,"all")
        % Perform nontrivial calculation where appropriate
        absAr = uint64(abs(Ar(isNontrivial)));
        absBr = uint64(abs(Br(isNontrivial)));
        absCr = zeros(size(absAr),"uint64");
        % Perform addition of absolute values where appropriate
        isAddition = Ar.IsNegative(isNontrivial)==Br.IsNegative(isNontrivial);
        if any(absAr(isAddition)>intmax("uint64")-absBr(isAddition))
            % Throw an error if the sum exceeds the maximal integer value
            errorID = "integerFactor:plus:exponentSumExceedsIntMax";
            message = "Sum of reduced operands exceeds the largest value of type 'uint64'. See INTMAX.";
            error(errorID,message)
        end
        absCr(isAddition) = absAr(isAddition)+absBr(isAddition);
        % Find where absolute values should be subtracted
        isSubtraction = ~isAddition;
        isGreaterAbsAr = absAr>absBr;
        isSubtractionWithGreaterAbsAr = isSubtraction & isGreaterAbsAr;
        if any(isSubtractionWithGreaterAbsAr)
            % Subtract absolute value of Br from Ar where appropriate
            absCr(isSubtractionWithGreaterAbsAr) = absAr(isSubtractionWithGreaterAbsAr)-absBr(isSubtractionWithGreaterAbsAr);
        end
        isSubtractionWithGreaterAbsBr = isSubtraction & ~isGreaterAbsAr;
        if any(isSubtractionWithGreaterAbsBr)
            % Subtract absolute value of Ar from Br where appropriate
            absCr(isSubtractionWithGreaterAbsBr) = absBr(isSubtractionWithGreaterAbsBr)-absAr(isSubtractionWithGreaterAbsBr);
        end
        % Perform prime factorization on the nontrivial results
        Cr(isNontrivial) = factors.integerFactors(absCr);
        % Find where signs of results should be negated
        CrIndices = find(isNontrivial);
        isNegativeCr = (isSubtractionWithGreaterAbsAr & Ar.IsNegative(CrIndices)) | ...
                       (isSubtractionWithGreaterAbsBr & Br.IsNegative(CrIndices));
        if any(isNegativeCr)
            % Negate signs of results where appropriate
            Cr(CrIndices(isNegativeCr)) = -Cr(CrIndices(isNegativeCr));
        end
    end
    % Multiply by the extracted common factors for final results
    C = R.*Cr;
end