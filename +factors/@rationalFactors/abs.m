function Y = abs(X)
    Y = X;
    Y.Numerator = abs(X.Numerator);
    Y.Denominator = abs(X.Denominator);
end