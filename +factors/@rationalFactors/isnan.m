function TF = isnan(A)
% ISNAN - Determine which array elements are NaN
%   This function returns a logical array indicating where the input array
%   is NaN (neither finite nor infinite).
%
%   Syntax
%     TF = ISNAN(A)
%
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also isfinite, isinf
    TF = A.Denominator.IsZero & A.Numerator.IsZero;
end