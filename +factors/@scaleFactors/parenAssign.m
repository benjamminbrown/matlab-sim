function obj = parenAssign(obj,indexOp,arg)
    arguments
        obj
        indexOp {mustBeScalarOrEmpty,mustBeNonempty}
        arg     {mustBeA(arg,"factors.scaleFactors")}
    end
    obj.Factors.(indexOp) = arg.Factors;
    obj.Exponents.(indexOp) = arg.Exponents;
end