function B = int16(A)
% INT16 - Convert variable to 'int16' data type
%   Variables in MATLAB of data type (class) int16 are stored as 2-byte
%   (16-bit) signed integers.
%
%   Syntax
%     Y = INT16(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also cast, int8, int32, int64
    B = cast(A,"int16");
end