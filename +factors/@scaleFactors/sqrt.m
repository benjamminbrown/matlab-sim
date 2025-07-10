function X = sqrt(X)
% sqrt - Square root
%   This function returns the square root of each element of the input
%   array.
%
%   Syntax
%     B = sqrt(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also nthroot

    % Call nthroot method with N=2
    X = nthroot(X,2);
end