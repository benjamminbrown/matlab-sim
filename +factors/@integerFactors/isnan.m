function TF = isnan(A)
% ISNAN - Determine which array elements are NaN
%   This function returns a logical array indicating where the input array
%   is NaN (neither finite nor infinite). This overloaded function will
%   always return false arrays for factors.integerFactors arrays.
%
%   Syntax
%     TF = ISNAN(A)
%
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also isfinite, isinf
    TF = false(size(A));
end