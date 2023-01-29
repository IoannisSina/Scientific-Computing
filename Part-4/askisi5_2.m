function [] = askisi5_2()
    %global A
    %global xsol
    n = 500; 
    A = randn(n); 
    xsol = rand(n,1); 
    b = A*xsol;
    tol = 10^-6; 
    maxit = 4*n; 
    m = 100;

    %----------------------PCG---------------------------------
    % A'*A so A is symmetric positive definite in order for pcg
    %to converge
    profile on
    [X1,FLAG1,RELRES1,ITER1,RESVEC1] = pcg(A'*A,A'*b,tol,maxit);
    profile viewer;
    profile off;
    %----------------------------------------------------------

    %----------------------GMRES m-----------------------------
    %profile on;
    [X2,FLAG2,RELRES2,ITER2,RESVEC2] = gmres(A,b,m,tol,maxit);
    %profile viewer;
    %profile off;
    %----------------------------------------------------------
    %----------------------GMRES n-----------------------------
    tic;
    %profile on;
    [X3,FLAG3,RELRES3,ITER3,RESVEC3] = gmres(A,b,n,tol,maxit);
    %profile viewer;
    %profile off;
    t1 = toc;
    %----------------------------------------------------------
    tic;
    x = A\b;
    t2 = toc;
    %-------------------------matrix 1,2-----------------------
    figure();
    semilogy(RESVEC1/norm(b),'-og','MarkerIndices', 1:50:ITER1);
    hold on;
    semilogy(RESVEC2(1:3000)/norm(b),'-xr','MarkerIndices', 1:100:3000);
    semilogy(RESVEC3/norm(b),'-*b','MarkerIndices', 1:50:ITER3);
    legend("PCG","GMRES restart=100","GMRES restart=500",'location','best');
    ylabel('$||B-A*X_i||_2/||B||_2$','interpreter','latex');
    xlabel("Iteration");
    title("Relative residual over iterations for 5.2");
    hold off;
    grid on;
    %------------------------------------------------------------------

    clc;
    fprintf("FLAG: %d PCG: It needed %d iterations and ~%d MV multiplications. Last error %f.\n",FLAG1,ITER1,ITER1+2,RELRES1*norm(b));
    fprintf("FLAG: %d GMRES with restart %d. It needed %d iterations and ~202001 MV multiplications. Last error %f.\n",FLAG2,m,prod(ITER2),RELRES2*norm(b));
    fprintf("FLAG: %d GMRES with restart %d. It needed %d iterations and ~502 MV multiplications. Last error %f.\n",FLAG3,n,prod(ITER3),RELRES3*norm(b));



    fprintf("Accurancy of result for PCG: %f.\n",norm(X1-xsol));
    fprintf("Accurancy of result for GMRES restart %d: %f.\n",m,norm(X2-xsol));
    fprintf("Accurancy of result for GMRES restart %d: %f.\n",n,norm(X3-xsol));

    fprintf("Time for gmres with restart 500: %f.\n",t1);
    fprintf("Time for A\\b: %f.\n",t2);
    if t2 < t1
        fprintf("A\\b faster than gmres with restart %d in this case.\n",n);
    end
end


