function varargout = size(obj,varargin)
    [varargout{1:nargout}] = size(obj.Factors,varargin{:});
end