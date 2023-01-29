function [P] = band_stats(mxid)
    
    %if mxid is string find matrixs id whose name is mxid
    if isstring(mxid)
        index = ssget;
        id = find(index.Name == mxid);
        if isempty(id)
            error("No matrix with such name");
        end
        temp = ssget(id);
        %keep matrix from the struct
        A = temp.A;
    elseif length(mxid) > 1
        A = mxid;
        
    else
        temp = ssget(mxid);
        A= temp.A;
        [m,n] = size(A);
        A = A(1:min([m n 1000]),1:min([m n 1000]));
    end
    %if mxid is not string and is not an array, then ssget returns error
    %for wrong types
    if size(A,1) ~= size(A,2)
        error("Matrix must be square");
    end
    p = length(A);
    %for every matrix keep nnz(A^k)/nnz(A) and rerr
    P = zeros(p,2);
    %calculate these values once as they remain tha same until the end
    nnz_of_A = nnz(A);
    norm_of_A = norm(A, 'fro');
    %-----------------------------------------------------------------
    %for 1 its only the diagonal
    P(1,1) = nnz(diag(A))/nnz_of_A;
    %p*p diagonal matrix with diag of A
    temp = diag(diag(A));
    P(1,2) = norm(A-temp, 'fro')/norm_of_A;
    
    %initially q = p = 0, bandwidth = 1 (diag of A)
    %next q = p = 1 -> bandwidth = 3...
    %final q = p = n-1 -> bandwidth = n-1 + n-1 +1 = 2n-1 
    %main loop n-1 to construct all band width matrices
    %in every loop we ADD the needed diagonals of A to temp
    %first iteration tridiagonio next pentadiagonio..last iteration A
    for j=1:p-1
        upper_diag = diag(diag(A,j),j);
        lower_diag = diag(diag(A,-j),-j);
        temp = temp + upper_diag + lower_diag;
        P(j+1, 1) = nnz(temp)/nnz_of_A;
        P(j+1, 2) = norm(A-temp, 'fro')/norm_of_A;
    end
          
end