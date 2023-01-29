function [y] = myMV(z)
    %to w pernei timew 0 h 1 kai analoga h diagonios tou A pernei times
    %an w=0 diag(A) = [4 4 4...4]^T enw an w=1 diag(A) = [3.9722...]^T

    global w;
    global counter;
    h = 1/(sqrt(length(z))+1);
    if w == 1
        diag_coefficient = 4 - (w^2*h^2);
    else
        diag_coefficient = 4;
    end
    %p = -1 for diag(A,1), diag(A,-1), diag(A,5), diag(A,-5)
    p = (-1)/h^2;
    %for diag
    y = (diag_coefficient/h^2)*z;
    %------------------
    len_z = length(z);
    N = sqrt(len_z);
    %------------------
    
    %for diag(1) we use mod to not multiply by zero
    for i=1:len_z - 1
        if mod(i,N) ~= 0
            y(i) = y(i) + p*z(i+1);
        end
        
    end
    %for diag (-1) we use mod to not multiply by zero
    for i=2:len_z
        if mod(i,N) ~= 1
            y(i) = y(i) + p*z(i-1);
        end
    end
    
    %for diag(5)
    for j=1:len_z-N
        y(j) = y(j) + p*z(j+N);
    end
    %for diag(-5)
    for k=N+1:len_z
        y(k) = y(k) + p*z(k-N);
    end
    counter = counter +1;
end