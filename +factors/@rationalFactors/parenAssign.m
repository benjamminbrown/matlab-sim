function obj = parenAssign(obj,indexOp,arg)
    arguments
        obj
        indexOp {mustBeScalarOrEmpty,mustBeNonempty}
        arg     {mustBeA(arg,"factors.rationalFactors")}
    end
    obj.Numerator.(indexOp) = arg.Numerator;
    obj.Denominator.(indexOp) = arg.Denominator;
end