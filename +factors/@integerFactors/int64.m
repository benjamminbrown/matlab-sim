function B = int64(A)
% INT64 - Convert variable to 'int64' data type
%   Variables in MATLAB of data type (class) int64 are stored as 8-byte
%   (64-bit) signed integers.
%
%   Syntax
%     Y = INT64(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also cast, int8, int16, int32
    B = cast(A,"int64");
end