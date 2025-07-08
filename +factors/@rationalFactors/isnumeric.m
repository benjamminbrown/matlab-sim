function TF = isnumeric(~)
% ISNUMERIC - Determine whether input is numeric array
%   This function returns a logical scalar indicating whether the input
%   array is of numeric data type. This overloaded function will always
%   return true for factors.rationalFactors arrays.
%
%   Syntax
%     TF = ISNUMERIC(A)
%
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also class, isa
    TF = true;
end