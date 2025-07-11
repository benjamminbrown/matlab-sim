function TF = isinf(A)
% ISINF - Determine which array elements are infinite
%   This function returns a logical array indicating where the input array
%   is infinite (neither finite nor NaN). This overloaded function will
%   always return false arrays for factors.integerFactors arrays.
%
%   Syntax
%     TF = ISINF(A)
%
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also isfinite, isnan
    TF = false(size(A));
end