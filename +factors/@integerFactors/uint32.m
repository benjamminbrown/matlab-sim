function B = uint32(A)
% UINT32 - Convert variable to 'uint32' data type
%   Variables in MATLAB of data type (class) uint32 are stored as 4-byte
%   (32-bit) unsigned integers.
%
%   Syntax
%     Y = UINT32(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also cast, uint8, uint16, uint64
    B = cast(A,"uint32");
end