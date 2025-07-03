function B = int32(A)
% INT32 - Convert variable to 'int32' data type
%   Variables in MATLAB of data type (class) int32 are stored as 4-byte
%   (32-bit) signed integers.
%
%   Syntax
%     Y = INT32(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also cast, int8, int16, int64
    B = cast(A,"int32");
end