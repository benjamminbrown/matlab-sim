function X = fix(X)
% FIX - Round toward zero
%   This function rounds each element of the input array to the nearest
%   integer toward zero.
%
%   Syntax
%     Y = FIX(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also ceil, floor, round

    % Check for finite values
    isFinite = isfinite(X);
    if any(isFinite,"all")
        % Fix the finite values to the nearest integer toward zero
        absN = uint64(abs(X.Numerator(isFinite)));
        absD = uint64(abs(X.Denominator(isFinite)));
        % Find where the sign of the result will need to be flipped
        isFiniteNegative = isFinite & X.Numerator.IsNegative~=X.Denominator.IsNegative;
        X(isFinite) = factors.rationalFactors((absN-mod(absN,absD))./absD);
        if any(isFiniteNegative,"all")
            % Flip the sign of the result where appropriate
            X(isFiniteNegative) = -X(isFiniteNegative);
        end
    end
end