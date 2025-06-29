function Y = round(X)
    shiftedX = X+factors.rationalFactors(1,2);
    Y = shiftedX-mod(shiftedX,1);
end