function [] = askisi5_1()
    n=500; 
    %tol = [] means default which is 10^(-6)
    %-------------------5.1.1------------------------------------------
    A1 =spdiags([1:n]',0,n,n);
    xsol1 = ones(n,1); 
    b1 = A1*xsol1;
    %profile on;
    [X1,FLAG1,RELRES1,ITER1,RESVEC1] = pcg(A1,b1,[],4*n);
    %profile viewer;
    %profile off;
    %------------------------------------------------------------------
    %-------------------5.1.2------------------------------------------

    A2 = spdiags([linspace(1,2,n/2)';linspace(1000,1001,n/2)'],0,n,n);
    xsol2 = ones(n,1); 
    b2 = A2*xsol2;
    %profile on;
    [X2,FLAG2,RELRES2,ITER2,RESVEC2] = pcg(A2,b2,[],4*n);
    %profile viewer;

    %profile off;

    %grid on;
    %------------------------------------------------------------------
    %-------------------------matrix 1---------------------------------
    figure();
    semilogy(RESVEC1/norm(b1),'-o');
    legend("Matrix 5.1.1",'location','best');
    ylabel('$||B-A*X_i||_2/||B||_2$','interpreter','latex');
    xlabel("Iteration");
    title("Relative residual over iterations for 5.1.1");
    grid on;
    %------------------------------------------------------------------
    %-------------------------matrix 2---------------------------------
    figure();
    semilogy(RESVEC2/norm(b2),'-o');
    legend("Matrix 5.1.2",'location','best');
    ylabel('$||B-A*X_i||_2/||B||_2$','interpreter','latex');
    xlabel("Iteration");
    title("Relative residual over iterations for 5.1.2");
    grid on;
    %------------------------------------------------------------------
    %-------------------------matrix 1,2-------------------------------
    figure();
    semilogy(RESVEC1/norm(b1),'-o');
    hold on;
    semilogy(RESVEC2/norm(b2),'-x');
    legend("Matrix 5.1.1","Matrix 5.1.2",'location','best');
    ylabel('$||B-A*X_i||_2/||B||_2$','interpreter','latex');
    xlabel("Iteration");
    title("Relative residual over iterations for 5.1.1 and 5.1.2");
    hold off;
    grid on;
    %------------------------------------------------------------------
    clc;
    if ~FLAG1
        fprintf("PCG for matrix 1 converged. It needed %d iterations and ~%d MV multiplications. Last error %f.\n",ITER1,ITER1+2,RELRES1*norm(b1));
    end
    if ~FLAG2
        fprintf("PCG for matrix 2 converged. It needed %d iterations and ~%d MV multiplications. Last error %f.\n",ITER2,ITER2+2,RELRES2*norm(b2));
    end


    
    fprintf("Accurancy of result for matrix 1: %f. Deikths katastashs for matrix 1: %d.\n",norm(X1-xsol1),condest(A1));
    fprintf("Accurancy of result for matrix 2: %f. Deikths katastashs for matrix 2: %d.\n",norm(X2-xsol2),condest(A2));
    
end

