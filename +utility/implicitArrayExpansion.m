function varargout = implicitArrayExpansion(varargin)
% UTILITY.IMPLICITARRAYEXPANSION - Expand singleton array dimensions
%   This utility function compares the size of the input arrays, then
%   implicitly expands their singleton dimensions as necessary until all of
%   the arrays have the same size. The best use case for this function is
%   to create temporary arrays in a function that would otherwise require
%   all input arrays to be of the same size.
% 
%   Syntax
%     [B1,...,BN] = utility.implicitArrayExpansion(A1,...,AN)
% 
%   Input Arguments
%     A1,...,AN - Input arrays
%       scalars | vectors | matrices | multidimensional arrays
%
%   Output Arguments
%     B1,...,BN - Implicitly expanded arrays
%       scalars | vectors | matrices | multidimensional arrays
%
%   See also size, repmat, bsxfun.

    % Compute size of each argument array
    argNdims = zeros(1,nargin);
    for argIndex = 1:nargin
        argNdims(argIndex) = ndims(varargin{argIndex});
    end
    implicitNdims = max(argNdims);
    argSizes = ones(nargin,implicitNdims);
    for argIndex = 1:nargin
        argSizes(argIndex,1:argNdims(argIndex)) = size(varargin{argIndex});
    end
    if ~all(argSizes(2:nargin,:)==argSizes(1,:),"all")
        % Compute implicitly expanded size
        implicitSize = ones(1,implicitNdims);
        for dimIndex = 1:implicitNdims
            uniqueSizes = unique(argSizes(:,dimIndex));
            isNotOne = uniqueSizes~=1;
            errorID = "utility:implicitExpansionFunction:incompatibleSizes";
            message = "Arrays have incompatible sizes for this operation.";
            assert(sum(isNotOne)<=1,errorID,message)
            if any(isNotOne)
                implicitSize(dimIndex) = uniqueSizes(isNotOne);
            end
        end
        % Expand singleton dimensions of argument arrays as necessary
        for argIndex = 1:nargin
            isExpandedDimension = implicitSize~=argSizes(argIndex,:);
            if any(isExpandedDimension)
                repFactors = ones(1,implicitNdims);
                repFactors(isExpandedDimension) = implicitSize(isExpandedDimension);
                varargin{argIndex} = repmat(varargin{argIndex},repFactors);
            end
        end
    end
    % Return implicitly expanded argument arrays
    [varargout{1:nargout}] = varargin{:};
end