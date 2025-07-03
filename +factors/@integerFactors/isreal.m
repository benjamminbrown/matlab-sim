function TF = isreal(~)
% ISREAL - Determine whether array uses complex storage
%   This function returns a logical scalar indicating whether the input
%   array does not have an imaginary part. This overloaded function will
%   always return true for factors.integerFactors arrays.
%
%   Syntax
%     TF = ISREAL(A)
%
%   Input Arguments
%     A - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also isnumeric, isa
    TF = true;
end