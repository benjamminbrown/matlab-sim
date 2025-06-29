function obj = parenDelete(obj,indexOp)
    obj.IsZero.(indexOp) = [];
    obj.IsNegative.(indexOp) = [];
    obj.Factors.(indexOp) = [];
    obj.Exponents.(indexOp) = [];
end