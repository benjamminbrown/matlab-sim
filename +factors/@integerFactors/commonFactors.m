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
%     A - First input array
%       scalar | vector | matrix | multidimensional array
%     B - Second input array
%       scalar | vector | matrix | multidimensional array
%
%   Output Arguments
%     R - Array of common factors
%       scalar | vector | matrix | multidimensional array
%     Ar - Reduced form of the first input array
%       scalar | vector | matrix | multidimensional array
%     Br - Reduced form of the second input array
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
            indices = find(isNontrivial);
            for elementIndex = 1:numel(indices)
                index = indices(elementIndex);
                if A.IsNegative(index) && B.IsNegative(index)
                    % Common factor is negative
                    R.IsNegative(index) = true;
                    Ar.IsNegative(index) = false;
                    Br.IsNegative(index) = false;
                end
                % Find matching prime factors
                commonFactors = Ar.Factors{index}(ismember(Ar.Factors{index},Br.Factors{index}));
                if ~isempty(commonFactors)
                    % Common prime factors found
                    R.Factors{index} = commonFactors;
                    numberOfFactors = length(R.Factors{index});
                    R.Exponents{index} = zeros([1,numberOfFactors],"uint8");
                    for factorIndexR = 1:numberOfFactors
                        % Calculate common factor exponent (multiplicity)
                        factorIndexAr = find(Ar.Factors{index}==R.Factors{index}(factorIndexR));
                        factorIndexBr = find(Br.Factors{index}==R.Factors{index}(factorIndexR));
                        if Ar.Exponents{index}(factorIndexAr)==Br.Exponents{index}(factorIndexBr)
                            R.Exponents{index}(factorIndexR) = Ar.Exponents{index}(factorIndexAr);
                            Ar.Factors{index}(factorIndexAr) = [];
                            Ar.Exponents{index}(factorIndexAr) = [];
                            Br.Factors{index}(factorIndexBr) = [];
                            Br.Exponents{index}(factorIndexBr) = [];
                        elseif Ar.Exponents{index}(factorIndexAr)<Br.Exponents{index}(factorIndexBr)
                            R.Exponents{index}(factorIndexR) = Ar.Exponents{index}(factorIndexAr);
                            Ar.Factors{index}(factorIndexAr) = [];
                            Ar.Exponents{index}(factorIndexAr) = [];
                            Br.Exponents{index}(factorIndexBr) = Br.Exponents{index}(factorIndexBr)-R.Exponents{index}(factorIndexR);
                        else
                            R.Exponents{index}(factorIndexR) = Br.Exponents{index}(factorIndexAr);
                            Ar.Exponents{index}(factorIndexAr) = Ar.Exponents{index}(factorIndexAr)-R.Exponents{index}(factorIndexR);
                            Br.Factors{index}(factorIndexBr) = [];
                            Br.Exponents{index}(factorIndexBr) = [];
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