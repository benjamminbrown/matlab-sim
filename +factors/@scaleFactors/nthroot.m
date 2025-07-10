function X = nthroot(X,N)
% NTHROOT - Real nth root of real numbers
%   This function returns the real Nth root of each element of the input
%   array.
%
%   Syntax
%     Y = NTHROOT(X,N)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%     N - Roots to calculate
%       scalar | vector | matrix | multidimensional array
%
%   See also sqrt, power
    arguments
        X   factors.scaleFactors
        N   factors.rationalFactors
    end
    % Invert root and pass to power method
    X = power(X,N.^-1);
end