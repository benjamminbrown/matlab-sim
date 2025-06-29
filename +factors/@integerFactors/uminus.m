function Y = uminus(X)
    Y = X;
    Y.IsNegative = ~X.IsNegative;
end