function TF = lt(A,B)
    [A,B] = utility.implicitArrayExpansion(A,B);
    if isempty(A)
        TF = logical.empty(size(A));
    else
        TF = ~isnan(A) & ~isnan(B);
        if any(TF,"all")
            TF(TF) = ~(A(TF)>=B(TF));
        end
    end
end