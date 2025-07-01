classdef dataArray < matlab.mixin.indexing.RedefinesParen & matlab.mixin.indexing.RedefinesBrace
    properties (SetAccess=protected)
        Dimension   {mustBeA(Dimension,"double"),mustBeRow,mustBeNonempty,mustBeInteger,mustBePositive} = [1,1]
        Data        {mustBeNumericOrLogical}                                                            = double.empty([1,1,0,0])
    end
    %% CONSTRUCTOR
    methods
        function obj = dataArray(varargin)
            switch nargin
                case 0
                    % Default constructor
                    return
                case {1,2}
                    % Scalar dimension constructor
                    mustBeValidClassnameArgument(varargin{1})
                    if nargin == 1
                        functionHandle = str2func(strcat(varargin{1},".empty"));
                        obj.Data = functionHandle([1,1,0,0]);
                    else
                        functionHandle = str2func(varargin{1});
                        obj.Data = reshape(functionHandle(varargin{2}),[1,1,size(varargin{2})]);
                    end
                otherwise
                    % Vector dimension constructor
                    mustBeValidVectorDimensionArgument(varargin{2});
                    if isrow(varargin{2})
                        dimension = varargin{2};
                    else
                        dimension = transpose(varargin{2});
                    end
                    assert(nargin==2+prod(dimension))
                    % Construct scalar dimension objects for each data argument
                    for argIndex = 3:nargin
                        varargin{argIndex} = dataArray(varargin{1},varargin{argIndex});
                    end
                    % Concatenate and reshape the vector dimension object
                    obj = dimcat(1,varargin{3:nargin});
                    obj.Data = reshape(obj.Data,[dimension,size(obj)]);
                    obj.Dimension = dimension;
            end
        end
    end
    %% PROTECTED METHODS
    methods (Access=protected)
        function varargout = braceReference(obj,indexOp)
            assert(length(indexOp(1).Indices)==length(obj.Dimension))
            dimension = size(subsref(reshape(1:prod(obj.Dimension),obj.Dimension),substruct("()",indexOp(1).Indices)));
            obj.Data = reshape(subsref(obj.Data,substruct("()",[indexOp(1).Indices,repmat({':'},1,ndims(obj))])),[dimension,size(obj)]);
            obj.Dimension = dimension;
            if isscalar(indexOp)
                varargout{1} = obj;
            else
                [varargout{1:nargout}] = obj.(indexOp(2:end));
            end
        end
        function obj = braceAssign(obj,indexOp,varargin)
            assert(isscalar(varargin) && isscalar(indexOp) || (length(indexOp)==2 && strcmp(indexOp(2).Type,"Paren")))
            assert(length(indexOp(1).Indices)==length(obj.Dimension))
            mustBeDataArray(varargin{1})
            mustHaveConsistentUnderlyingTypes(obj,varargin{1})
            dimensionIndices = indexOp(1).Indices;
            if isscalar(indexOp)
                mustHaveConsistentSizes(obj,varargin{1})
                sizeIndices = repmat({':'},1,ndims(obj));
            else
                sizeIndices = indexOp(2).Indices;
            end
            obj.Data = subsasgn(obj.Data,substruct("()",[dimensionIndices,sizeIndices]),varargin{1}.Data);
        end
        function n = braceListLength(obj,indexOp,indexContext)
            if isscalar(indexOp)
                n = 1;
            else
                n = listLength(obj.(indexOp(1)),indexOp(2:end),indexContext);
            end
        end
        function varargout = parenReference(obj,indexOp)
            obj.Data = subsref(obj.Data,substruct("()",[repmat({':'},1,length(obj.Dimension)),indexOp(1).Indices]));
            if isscalar(indexOp)
                varargout{1} = obj;
            else
                [varargout{1:nargout}] = obj.(indexOp(2:end));
            end
        end
        function obj = parenAssign(obj,indexOp,varargin)
            assert(isscalar(varargin) && isscalar(indexOp))
            mustBeDataArray(varargin{1})
            mustHaveConsistentUnderlyingTypes(obj,varargin{1})
            mustHaveConsistentDimensions(obj,varargin{1})
            obj.Data = subsasgn(obj.Data,substruct("()",[repmat({':'},1,length(obj.Dimension)),indexOp(1).Indices]),varargin{1}.Data);
        end
        function n = parenListLength(obj,indexOp,indexContext)
            if isscalar(indexOp)
                n = 1;
            else
                n = listLength(obj.(indexOp(1)),indexOp(2:end),indexContext);
            end
        end
        function obj = parenDelete(obj,indexOp)
            assert(isscalar(indexOp))
            obj.Data = subsasgn(obj.Data,substruct("()",[repmat({':'},1,length(obj.Dimension)),indexOp(1).Indices]),[]);
        end
        function obj = dimcat(dim,varargin)
            arguments
                dim         {mustBeValidScalarDimensionArgument}
            end
            arguments (Repeating)
                varargin    {mustBeA(varargin,"array.dataArray")}
            end
            try
                mustHaveConsistentUnderlyingTypes(varargin{:})
            catch ME
                errorID = "dataArray:cat:dataMismatch";
                error(errorID,ME.message)
            end
            try
                mustHaveConsistentSizes(varargin{:})
            catch ME
                errorID = "dataArray:dimcat:sizeMismatch";
                error(errorID,ME.message)
            end
            obj = varargin{1};
            numberOfDimensions = length(obj.Dimension);
            for argIndex = 1:nargin-1
                argDimension = [varargin{argIndex}.Dimension,ones(1,dim-numberOfDimensions)];
                if argIndex==1
                    obj.Dimension = argDimension;
                else
                    errorID = "dataArray:dimcat:dimensionMismatch";
                    message = "Arguments must have a consistent dimensions.";
                    assert(length(varargin{argIndex}.Dimension)==numberOfDimensions && ...
                           all(varargin{argIndex}.Dimension(1:numberOfDimensions~=dim)==obj.Dimension(1:numberOfDimensions~=dim)), ...
                           errorID,message)
                    obj.Dimension(dim) = obj.Dimension(dim)+argDimension(dim);
                end
                varargin{argIndex} = reshape(varargin{argIndex}.Data,[argDimension,size(varargin{argIndex})]);
            end
            obj.Data = cat(dim,varargin{1:nargin-1});
        end
    end
    %% PUBLIC METHODS
    methods(Access=public)
        function typename = underlyingType(obj)
            typename = class(obj.Data);
        end
        function C = ne(A,B)
            mustBeDataArray(A,B)
            mustHaveConsistentDimensions(A,B)
            C = shiftdim(any(A.Data~=B.Data,1:length(A.Dimension)),length(A.Dimension));
        end
        function C = eq(A,B)
            mustBeDataArray(A,B)
            mustHaveConsistentDimensions(A,B)
            C = shiftdim(all(A.Data==B.Data,1:length(A.Dimension)),length(A.Dimension));
        end
        function obj = transpose(obj)
            errorID = "dataArray:transpose:NDArray";
            message = "TRANSPOSE does not support N-D arrays. Use PAGETRANSPOSE/PAGECTRANSPOSE to transpose pages or PERMUTE to reorder dimensions of N-D arrays.";
            assert(ismatrix(obj),errorID,message)
            obj = permute(obj,[2,1]);
        end
        function obj = permute(obj,dimorder)
            try
                mustBeValidVectorDimensionArgument(dimorder)
            catch ME
                errorID = "dataArray:permute:badIndex";
                error(errorID,ME.message)
            end
            errorID = "dataArray:permute:tooFewIndices";
            message = "Dimension order argument must have at least N elements for an N-D array.";
            assert(length(dimorder)>=ndims(obj),errorID,message)
            obj.Data = permute(obj.Data,[1:length(obj.Dimension),dimorder+length(obj.Dimension)]);
        end
        function obj = reshape(obj,varargin)
            assert(nargin>=2)
            if nargin == 2
                try
                    mustBeValidVectorSizeArgument(varargin{1})
                catch ME
                    errorID = "dataArray:reshape:invalidSize";
                    error(errorID,ME.message)
                end
                if isrow(varargin{1})
                    dataSize = [obj.Dimension,varargin{1}];
                else
                    dataSize = [obj.Dimension,transpose(varargin{1})];
                end
            else
                for argIndex = 1:nargin-1
                    try
                        mustBeValidScalarSizeArgument(varargin{argIndex})
                    catch ME
                        errorID = "dataArray:reshape:invalidScalarSize";
                        error(errorID,ME.message)
                    end
                end
                dataSize = [obj.Dimension,varargin{:}];
            end
            obj.Data = reshape(obj.Data,dataSize);
        end
        function obj = cat(dim,varargin)
            arguments
                dim         {mustBeValidScalarDimensionArgument}
            end
            arguments (Repeating)
                varargin    {mustBeA(varargin,"array.dataArray")}
            end
            try
                mustHaveConsistentUnderlyingTypes(varargin{:})
            catch ME
                errorID = "dataArray:cat:dataMismatch";
                error(errorID,ME.message)
            end
            try
                mustHaveConsistentDimensions(varargin{:})
            catch ME
                errorID = "dataArray:cat:dimensionMismatch";
                error(errorID,ME.message)
            end
            obj = varargin{1};
            for argIndex = 1:nargin-1
                if isempty(varargin{argIndex})
                    varargin{argIndex} = [];
                else
                    varargin{argIndex} = varargin{argIndex}.Data;
                end
            end
            obj.Data = cat(dim+length(obj.Dimension),varargin{1:nargin-1});
        end
        function varargout = size(obj,varargin)
            numberOfDimensions = length(obj.Dimension);
            if nargin==1
                if nargout<2
                    varargin{1} = numberOfDimensions+1:max(ndims(obj.Data),numberOfDimensions+2);
                else
                    varargin{1} = numberOfDimensions+(1:nargout);
                end
            elseif nargin==2
                try
                    mustBeValidDimensionArgument(varargin{1})
                catch ME
                    errorID = "dataArray:size:invalidDimension";
                    error(errorID,ME.message)
                end
                if ~isempty(varargin{1})
                    varargin{1} = varargin{1}+numberOfDimensions;
                end
            else
                for argIndex = 1:nargin-1
                    try
                        mustBeValidScalarDimensionArgument(varargin{argIndex})
                    catch ME
                        errorID = "dataArray:size:invalidScalarDimension";
                        error(errorID,ME.message)
                    end
                    varargin{argIndex} = varargin{argIndex}+numberOfDimensions;
                end
            end
            [varargout{1:nargout}] = size(obj.Data,varargin{:});
        end
        function ind = end(obj,k,n)
            warningID = "dataArray:end:notRecommended";
            message = "The end indexing method may not work as expected when brace indexing into array.dataArray objects.";
            warning(warningID,message)
            ind = end@matlab.mixin.indexing.RedefinesParen(obj,k,n);
        end
    end
    %% STATIC PUBLIC METHODS
    methods (Static,Access=public)
        function obj = empty(classname,dimension,varargin)
            arguments
                classname   {mustBeValidClassnameArgument}
                dimension   {mustBeValidVectorDimensionArgument}
            end
            arguments (Repeating)
                varargin
            end
            emptyFunction = str2func(strcat(classname,".empty"));
            [dataArgs{1:prod(dimension)}] = deal(emptyFunction(varargin{:}));
            obj = array.dataArray(classname,dimension,dataArgs{:});
        end
        function obj = createArray(dims,fillValue)
            arguments
                dims        {mustBeValidVectorSizeArgument}
                fillValue                                   = 0
            end
            obj = repmat(array.dataArray(class(fillValue),fillValue),dims);
        end
    end
end

%% VALIDATION FUNCTIONS
function mustBeDataArray(varargin)
    message = "Argument must be an array.dataArray object.";
    for argIndex = 1:nargin
        assert(isa(varargin{argIndex},"array.dataArray"),message)
    end
end
function mustHaveScalarDimension(varargin)
    message = "Arguments must have scalar dimension.";
    for argIndex = 1:nargin
        assert(prod(varargin{argIndex}.Dimension)==1,message)
    end
end
function mustHaveConsistentUnderlyingTypes(varargin)
    message = "Arguments must have consistent underlying types.";
    typename = underlyingType(varargin{1});
    for argIndex = 2:nargin
        assert(strcmp(underlyingType(varargin{argIndex}),typename),message)
    end
end
function mustHaveConsistentDimensions(varargin)
    message = "Arguments must have consistent dimensions.";
    dimension = varargin{1}.Dimension;
    numberOfDimensions = length(dimension);
    for argIndex = 2:nargin
        assert(length(varargin{argIndex}.Dimension)==numberOfDimensions && ...
               all(varargin{argIndex}.Dimension==dimension), ...
               message)
    end
end
function mustHaveConsistentSizes(varargin)
    message = "Arguments must have consistent sizes.";
    argSize = size(varargin{1});
    numberOfDimensions = length(argSize);
    for argIndex = 2:nargin
        assert(ndims(varargin{argIndex})==numberOfDimensions && ...
               all(size(varargin{argIndex})==argSize), ...
               message)
    end
end
function mustBeValidClassnameArgument(arg)
    message = "Class name argument must be a text scalar representing the name of a numeric or logical class.";
    try
        mustBeTextScalar(arg)
    catch
        error(message)
    end
    assert(any(strcmp(arg,["logical","double","single","int8","int16","int32","int64","uint8","uint16","uint32","uint64"])),message)
end
function mustBeValidDimensionArgument(arg)
    message = "Dimension argument must be a positive integer scalar or a vector of positive integers. When an empty dimension argument is specified, it must be a 0-by-0, 1-by-0, or 0-by-1 array.";
    assert(isnumeric(arg) || islogical(arg))
    if isempty(arg)
        assert(isvector(arg) || ismatrix(arg),message)
    else
        assert(isvector(arg) && isreal(arg) && ...
               all(arg==round(arg) & arg>0),message)
    end
end
function mustBeValidVectorDimensionArgument(arg)
    message = "Dimension argument must be a vector of positive integers with at least two elements.";
    assert((isnumeric(arg) || islogical(arg)) && ...
           ~isempty(arg) && isvector(arg) && isreal(arg) && ...
           length(arg)>=2 && all(arg==round(arg) & arg>0), ...
           message)
end
function mustBeValidScalarDimensionArgument(arg)
    message = "Dimension argument must be a positive integer scalar.";
    assert((isnumeric(arg) || islogical(arg)) && ...
           ~isempty(arg) && isscalar(arg) && isreal(arg) && ...
           arg==round(arg) && arg>0, ...
           message)
end
function mustBeValidVectorSizeArgument(arg)
    message = "Size argument must be a vector of nonnegative integers with at least two elements.";
    assert((isnumeric(arg) || islogical(arg)) && ...
           ~isempty(arg) && isvector(arg) && isreal(arg) && ...
           length(arg)>=2 && all(arg==round(arg) & arg>=0), ...
           message)
end
function mustBeValidScalarSizeArgument(arg)
    message = "Size argument must be a nonnegative integer scalar.";
    assert((isnumeric(arg) || islogical(arg)) && ...
           ~isempty(arg) && isscalar(arg) && isreal(arg) && ...
           arg==round(arg) && arg>=0, ...
           message)
end