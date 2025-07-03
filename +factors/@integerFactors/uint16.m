function B = uint16(A)
% UINT16 - Convert variable to 'uint16' data type
%   Variables in MATLAB of data type (class) uint16 are stored as 2-byte
%   (16-bit) unsigned integers.
%
%   Syntax
%     Y = UINT16(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also cast, uint8, uint32, uint64
    B = cast(A,"uint16");
end