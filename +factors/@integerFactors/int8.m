function B = int8(A)
% INT8 - Convert variable to 'int8' data type
%   Variables in MATLAB of data type (class) int8 are stored as 1-byte
%   (8-bit) signed integers.
%
%   Syntax
%     Y = INT8(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also cast, int16, int32, int64
    B = cast(A,"int8");
end