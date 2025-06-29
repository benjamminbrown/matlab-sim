function obj = parenDelete(obj,indexOp)
    obj.Numerator.(indexOp) = [];
    obj.Denominator.(indexOp) = [];
end