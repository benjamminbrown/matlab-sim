function C = mpower(~,~) %#ok<STOUT>
    errorID = "integerFactors:mpower:notSupported";
    message = "The matrix power method is not supported for objects of type 'factors.integerFactors'.";
    error(errorID,message)
end