function obj = parenDelete(obj,indexOp)
    obj.Factors.(indexOp) = [];
    obj.Exponents.(indexOp) = [];
end