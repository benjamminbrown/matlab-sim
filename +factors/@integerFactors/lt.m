function TF = lt(A,B)
% LT - Determine less than
%   This function returns a logical array indicating where the first input
%   array is less than the second input array.
%
%   Syntax
%     A < B
%     LT(A,B)
%
%   Input Arguments
%     A - Left operand
%       scalar | vector | matrix | multidimensional array
%     B - Right operand
%       scalar | vector | matrix | multidimensional array
%
%   See also eq, ge, gt, le, ne

    % Implicitly expand singleton dimensions of input arrays
    [A,B] = utility.implicitArrayExpansion(A,B);
    if isempty(A)
        % Return empty array
        TF = logical.empty(size(A));
    else
        % Return false if A or B are NaN
        TF = ~(isnan(A) | isnan(B));
        if any(TF,"all")
            % Compare elements where A and B are finite or infinite
            TF(TF) = ~(A(TF)>=B(TF));
        end
    end
end