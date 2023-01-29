function [ten] = Askisi3_1(A,k) 
    %add path tensor toolbox which is included in directory
    %a^1 SHOWS NUMBER OF PATHS of length 1 from i to j ...
    %a^k shows number of paths of length k from i to j..
    addpath('tensor_toolbox');
    if size(A,1) ~= size(A,2)
        error("Adjacency matrix must be square")
    end
    n = length(A); %plithos korifwn
    matrix = zeros(n,n,k); %arxikopoihsh
    matrix(:,:,1) = A;
    for i=2:k
        matrix(:,:,i) = matrix(:,:,i-1)*A;
    end
    ten = tensor(matrix);
end

