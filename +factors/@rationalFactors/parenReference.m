function varargout = parenReference(obj,indexOp)
    obj.Numerator = obj.Numerator.(indexOp(1));
    obj.Denominator = obj.Denominator.(indexOp(1));
    if isscalar(indexOp)
        varargout{1} = obj;
    else
        [varargout{1:nargout}] = obj.(indexOp(2:end));
    end
end