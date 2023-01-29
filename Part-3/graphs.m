function [] = graphs()
    %rajat04
    P1 = band_stats("rajat04");
    
    %gallery('wathen',10,20)
    a = gallery('wathen',10,20);
    P2 = band_stats(a);
    
    %pick by AM
    k = 1+mod(9610,2892);
    P3 = band_stats(k);
    
    %--------------------------graph1--------------------------------
    %----------------------------------------------------------------
    figure;
    plot(P1(:,1), '-xr', 'MarkerIndices', 1:30:length(P1(:,1)));
    hold on
    plot(P1(:,2), '-ob', 'MarkerIndices', 1:30:length(P1(:,1)));
    hold off
    legend('rnnz', 'rerr','Location', 'best');
    xlabel('Bandwidth');
    ylabel('$nnz(A^{(k)})/nnz(A)$ and $||A^{(k)}-A||/||A||$'...
        ,'interpreter','latex');
    title('Band statistics for rajat04 (1041x1041)');
    %----------------------------------------------------------------
    %--------------------------graph2--------------------------------
    %----------------------------------------------------------------
    
    figure;
    plot(P2(:,1), '-xr', 'MarkerIndices', 1:30:length(P2(:,1)));
    hold on
    plot(P2(:,2), '-ob', 'MarkerIndices', 1:30:length(P2(:,1)));
    hold off
    legend('rnnz', 'rerr','Location', 'best');
    xlabel('Bandwidth');
    ylabel('$nnz(A^{(k)})/nnz(A)$ and $||A^{(k)}-A||/||A||$'...
        ,'interpreter','latex');
    title('Band statistics for gallery(wathen,10,20) (661x661)');
    %----------------------------------------------------------------
    %--------------------------graph2--------------------------------
    %----------------------------------------------------------------
    
    figure;
    plot(P3(:,1), '-xr', 'MarkerIndices', 1:30:length(P3(:,1)));
    hold on
    plot(P3(:,2), '-ob', 'MarkerIndices', 1:30:length(P3(:,1)));
    hold off
    legend('rnnz', 'rerr','Location', 'best');
    xlabel('Bandwidth');
    ylabel('$nnz(A^{(k)})/nnz(A)$ and $||A^{(k)}-A||/||A||$'...
        ,'interpreter','latex');
    title('Band statistics for Lucifora/cell2 (7055x7055)');
    %----------------------------------------------------------------
end