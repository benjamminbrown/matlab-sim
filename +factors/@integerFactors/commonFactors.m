function varargout = commonFactors(A,B)
% COMMONFACTORS - Extract common factors
%   This function returns an array of the common factors between the two
%   input factors.integerFactors arrays. Additionally, it can return the
%   reduced forms of the input arrays with the common factors removed.
%
%   Syntax
%     R = commonFactors(A,B)
%     [R,Ar,Br] = commonFactors(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   Output Arguments
%     R - Array of common factors
%       scalar | vector | matrix | multidimensional array
%     Ar - Reduced form of the left operand
%       scalar | vector | matrix | multidimensional array
%     Br - Reduced form of the right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also factor
    arguments (Input)
        A   factors.integerFactors
        B   factors.integerFactors
    end
    % Perform output argument validation
    try
        nargoutchk(0,3)
        message = "Number of output arguments must be one or three.";
        assert(nargout~=2,message)
    catch ME
        errorID = "integerFactors:validation:nargoutchk";
        error(errorID,ME.message)
    end
    % Implicitly expand singleton dimensions of input arrays
    [A,B] = utility.implicitArrayExpansion(A,B);
    if isempty(A)
        % Return empty arrays
        [varargout{1:nargout}] = deal(factors.integerFactors.empty(size(A)));
    else
        % Extract any common factors
        R = factors.integerFactors.ones(size(A));
        Ar = A;
        Br = B;
        % Nontrivial calculation will be required if A and B are nonzero
        isNontrivial = ~(A.IsZero | B.IsZero);
        if any(isNontrivial,"all")
            elementIndices = find(isNontrivial);
            for elementIndex = elementIndices(:).'
                if A.IsNegative(elementIndex) && B.IsNegative(elementIndex)
                    % Common factor is negative
                    R.IsNegative(elementIndex) = true;
                    Ar.IsNegative(elementIndex) = false;
                    Br.IsNegative(elementIndex) = false;
                end
                % Find matching prime factors
                commonFactors = Ar.Factors{elementIndex}(ismember(Ar.Factors{elementIndex},Br.Factors{elementIndex}));
                if ~isempty(commonFactors)
                    % Common prime factors found
                    R.Factors{elementIndex} = commonFactors;
                    numberOfFactors = length(R.Factors{elementIndex});
                    R.Exponents{elementIndex} = zeros([1,numberOfFactors],"uint8");
                    for factorIndexR = 1:numberOfFactors
                        % Calculate common factor exponent (multiplicity)
                        factorIndexAr = find(Ar.Factors{elementIndex}==R.Factors{elementIndex}(factorIndexR));
                        factorIndexBr = find(Br.Factors{elementIndex}==R.Factors{elementIndex}(factorIndexR));
                        if Ar.Exponents{elementIndex}(factorIndexAr)==Br.Exponents{elementIndex}(factorIndexBr)
                            R.Exponents{elementIndex}(factorIndexR) = Ar.Exponents{elementIndex}(factorIndexAr);
                            Ar.Factors{elementIndex}(factorIndexAr) = [];
                            Ar.Exponents{elementIndex}(factorIndexAr) = [];
                            Br.Factors{elementIndex}(factorIndexBr) = [];
                            Br.Exponents{elementIndex}(factorIndexBr) = [];
                        elseif Ar.Exponents{elementIndex}(factorIndexAr)<Br.Exponents{elementIndex}(factorIndexBr)
                            R.Exponents{elementIndex}(factorIndexR) = Ar.Exponents{elementIndex}(factorIndexAr);
                            Ar.Factors{elementIndex}(factorIndexAr) = [];
                            Ar.Exponents{elementIndex}(factorIndexAr) = [];
                            Br.Exponents{elementIndex}(factorIndexBr) = Br.Exponents{elementIndex}(factorIndexBr)-R.Exponents{elementIndex}(factorIndexR);
                        else
                            R.Exponents{elementIndex}(factorIndexR) = Br.Exponents{elementIndex}(factorIndexAr);
                            Ar.Exponents{elementIndex}(factorIndexAr) = Ar.Exponents{elementIndex}(factorIndexAr)-R.Exponents{elementIndex}(factorIndexR);
                            Br.Factors{elementIndex}(factorIndexBr) = [];
                            Br.Exponents{elementIndex}(factorIndexBr) = [];
                        end
                    end
                end
            end
        end
        % Return results of common factor extraction
        if nargout<=1
            [varargout{1:nargout}] = R;
        else
            varargout{1} = R;
            varargout{2} = Ar;
            varargout{3} = Br;
        end
    end
end