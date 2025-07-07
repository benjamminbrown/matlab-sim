function X = round(X)
    shiftedX = X+factors.rationalFactors(1,2);
    X = shiftedX-mod(shiftedX,1);
end