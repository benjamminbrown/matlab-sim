function Y = sign(X)
    Y = factors.integerFactors.zeros(size(X));
    Y.IsZero(~X.IsZero) = false;
    Y.IsNegative(X.IsNegative) = true;
end