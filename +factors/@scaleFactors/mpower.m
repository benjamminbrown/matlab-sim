function C = mpower(~,~) %#ok<STOUT>
    errorID = "scaleFactors:mpower:notSupported";
    message = "The matrix power method is not supported for objects of type 'factors.scaleFactors'.";
    error(errorID,message)
end