function B = double(A)
% DOUBLE - Convert variable to 'double' data type
%   double is the default numeric data type (class) in MATLAB, providing
%   sufficient precision for most computational tasks.
%
%   Syntax
%     Y = DOUBLE(X)
%
%   Input Arguments
%     X - Input array
%       scalar | vector | matrix | multidimensional array
%
%   See also cast, single
    B = cast(A,"double");
end