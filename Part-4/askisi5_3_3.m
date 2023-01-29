function [] = askisi5_3_3(A,G)
    %run after askisi5_3_1 script so we have omega N = 127 kai omega 0 h 1
    global w;
    global counter;
    %kseroume pws to A einai panta Symmetrika thetika orismeno logw twn
    %sintelestwn kai ths domhs. SYNEPWS xrhsimopoioyme pcg
    %ta apotelesmata eksartontai apo to omega. Trekste mia me w=1 mia me 
    %w=0;
    %--------------------------------------------------------------------
    clc;
    %no preconditioning pcg
    %profile on;
    [X1,FLAG1,RELRES1,ITER1,RESVEC1] = pcg(@myMV,G,10^-6,length(A));
    fprintf("Multiplications for PCG global counter: %d.\n",counter);
    counter = 0;
    %profile viewer;
    %profile off;
    
    %no preconditioning minres gia symetrika mhtrwa
    %profile on;
    [L,U] = ilu(A);
    [X2,FLAG2,RELRES2,ITER2,RESVEC2] = pcg(@myMV,G,10^-6,length(A),L,U);
    fprintf("Multiplications for PCG ilu global counter: %d.\n",counter);
    counter = 0;
    %profile viewer;
    %profile off;
    %preconditioning with ichol pcg
    
    M1 = ichol(A);
    profile on;
    [X3,FLAG3,RELRES3,ITER3,RESVEC3] = pcg(@myMV,G,10^-6,length(A),M1,M1');
    fprintf("Multiplications for PCG ichol global counter: %d.\n",counter);
    counter = 0;
    profile viewer;
    profile off; 
    
    
    %preconditioning with ilu
    %[L1,U1] = ilu(A);
    %[X3,FLAG3,RELRES3,ITER3,RESVEC3] = pcg(@myMV,G,10^-6,length(A),L1,U1);
    %--------------------------------------------------------------------
    
    semilogy(RESVEC1/norm(G),'-o','MarkerIndices', 1:4:ITER1);
    hold on;
    semilogy(RESVEC2/norm(G),'-x','MarkerIndices', 1:4:ITER2);
    semilogy(RESVEC3/norm(G),'-^','MarkerIndices', 1:4:ITER3);
    legend("No precondition PCG","PCG - ichol",...
        "PCG - ilu",'location','best');
    ylabel('$||B-A*X_i||_2/||B||_2$','interpreter','latex');
    xlabel("Iteration");
    title("Relative residual over iterations for �=" + num2str(w));
    hold off;
    grid on;
    
    %-----------symperasmata--------------------------------------------
    %clc;
    fprintf("Shown results are for �="+num2str(w)+"\n");
    fprintf("FLAG: %d PCG with no precondition needed %d iterations and ~%d MV multiplications. Last error %d.\n",FLAG1,ITER1,ITER1+2,RELRES1*norm(G));
    fprintf("FLAG: %d PCG with ilu preconditioner needed %d iterations and ~%d MV multiplications. Last error %d.\n",FLAG2,ITER2,ITER2+2,RELRES2*norm(G));
    fprintf("FLAG: %d PCG with ichol preconditioner needed %d iterations and ~%d MV multiplications. Last error %d.\n",FLAG3,ITER3,ITER3+2,RELRES3*norm(G));

    
    sol = ones(length(A),1);
    fprintf("Accurancy of result for PCG no precondition: %f.\n",norm(X1-sol));
    fprintf("Accurancy of result for PCG with ilu preconditioner: %f.\n",norm(X2-sol));
    fprintf("Accurancy of result for PCG with ichol preconditioner: %f.\n",norm(X3-sol));
end