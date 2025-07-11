function B = single(A)
% SINGLE - Convert variable to 'single' data type
%   Single-precision variables in MATLAB are stored as 4-byte (32-bit)
%   floating-point values of data type (class) single.
%
%   Syntax
%     Y = SINGLE(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also cast, double
    B = cast(A,"single");
end