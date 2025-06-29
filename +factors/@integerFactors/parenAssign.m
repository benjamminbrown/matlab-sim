function obj = parenAssign(obj,indexOp,arg)
    arguments
        obj
        indexOp {mustBeScalarOrEmpty,mustBeNonempty}
        arg     {mustBeA(arg,"factors.integerFactors")}
    end
    obj.IsZero.(indexOp) = arg.IsZero;
    obj.IsNegative.(indexOp) = arg.IsNegative;
    obj.Factors.(indexOp) = arg.Factors;
    obj.Exponents.(indexOp) = arg.Exponents;
end