function B = uint64(A)
% UINT64 - Convert variable to 'uint64' data type
%   Variables in MATLAB of data type (class) uint64 are stored as 8-byte
%   (64-bit) unsigned integers.
%
%   Syntax
%     Y = UINT64(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also cast, uint8, uint16, uint32
    B = cast(A,"uint64");
end