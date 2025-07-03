function TF = isfinite(A)
% ISFINITE - Determine which array elements are finite
%   This function returns a logical array indicating where the input array
%   is finite (neither infinite nor NaN). This overloaded function will
%   always return true arrays for factors.integerFactors arrays.
%
%   Syntax
%     TF = ISFINITE(A)
%
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also isinf, isnan
    TF = true(size(A));
end