function varargout = implicitArrayExpansion(varargin)
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