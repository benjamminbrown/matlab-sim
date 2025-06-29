function C = mpower(~,~) %#ok<STOUT>
    errorID = "rationalFactors:mpower:notSupported";
    message = "The matrix power method is not supported for objects of type 'factors.rationalFactors'.";
    error(errorID,message)
end