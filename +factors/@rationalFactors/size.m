function varargout = size(obj,varargin)
    [varargout{1:nargout}] = size(obj.Numerator,varargin{:});
end