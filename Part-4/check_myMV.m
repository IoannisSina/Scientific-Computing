function [] = check_myMV(A)
    %check function myMV
    %run after askisi5_3_1 script
    clc;
    z = floor(1000*rand(length(A),1));
    y = myMV(z);
    real = A*z;

    clc;
    %%d to show the real value
    fprintf("Error for a random vector of function myMV: %d.\n",norm(y-real));
end
