function n = parenListLength(obj,indexOp,indexContext)
    if isscalar(indexOp)
        n = 1;
    else
        n = listLength(obj.(indexOp(1)),indexOp(2:end),indexContext);
    end
end