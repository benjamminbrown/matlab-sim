function varargout = parenReference(obj,indexOp)
    obj.IsZero = obj.IsZero.(indexOp(1));
    obj.IsNegative = obj.IsNegative.(indexOp(1));
    obj.Factors = obj.Factors.(indexOp(1));
    obj.Exponents = obj.Exponents.(indexOp(1));
    if isscalar(indexOp)
        varargout{1} = obj;
    else
        [varargout{1:nargout}] = obj.(indexOp(2:end));
    end
end