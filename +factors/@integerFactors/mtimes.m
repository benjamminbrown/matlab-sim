function C = mtimes(A,B)
    arguments
        A   factors.integerFactors
        B   factors.integerFactors
    end
    if ~(isscalar(A) || isscalar(B))
        % Throw error if neither input is a scalar
        errorID = "integerFactors:mtimes:matrixMultiplicationNotImplemented";
        message = "Matrix multiplication has not been implemented for arrays of type 'factors.integerFactors'.";
        error(errorID,message)
    else
        % Pass inputs to times method
        C = times(A,B);
    end
end