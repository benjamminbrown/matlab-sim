function B = uint8(A)
% UINT8 - Convert variable to 'uint8' data type
%   Variables in MATLAB of data type (class) uint8 are stored as 1-byte
%   (8-bit) unsigned integers.
%
%   Syntax
%     Y = UINT8(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also cast, uint16, uint32, uint64
    B = cast(A,"uint8");
end