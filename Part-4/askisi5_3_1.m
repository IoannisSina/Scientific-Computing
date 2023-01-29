 
% D = [0,1], [0,1]
%We will have 5x5 points so We will have 25 unkowns and 25 equations
%homogenous dirichlet boundaries means that every point which is on the
%bounds for example u(0,_),u(N+1,_),u(_,0),u(_,N+1) is equal to 0.
%w=1 for 5.3.1
%sto prwto shmeio tou plegmatos exoume 2 sinoriaka shmeia shnepws h prwth
%grammh toy A tha exei 3 syntelestes (3 apo tous 5)
%ta epomena 3 shmeia tha exoun ena sinoriako opote h grammes 2,3,4 toy A
%tha exoyn 4 syntelestes kai to pepto shmeio tha exei pali 2 opote h
%grammh 5 tou A tha exei 3 syntelestes kai pali
%oi mones grammew pou tha exoyn 5 sintelestes einai aftes poy anaferontai
%se shmeia entow toy plegmatos dhladh poy den xreiazontai sinoriaka shmeia
%first equation 3.9722*U11 - U21 - U12 = 0.0278*G11
global counter;
%count multiplications
counter = 0;
global w;
clc;
N = input("����� � ��� �������� ���������:\n");
w = input("����� � (0 � 1):\n");
if w ~= 0 && w~= 1
    error("W must be 0 or 1");
end
%1-0 = 1
h = 1/(N+1);
A = zeros(N^2);

matrix_row = 1;
for i=1:N
    for j=1:N
        %check for akra ektos plegmatos(sinora)
        
        %Ui,j no need for check as it refers to point inside the square
        A(matrix_row, (i-1)*N + j) = 4 - (w^2 * h^2);%
        
        %check if point on sinoro
        if j-1 ~= 0
            %Ui-1,j
            A(matrix_row, (i-1)*N + (j-1)) = -1;
        end

        if j+1 ~= N+1
            %Ui+1,j
            A(matrix_row, (i-1)*N + (j+1)) = -1;
        end

        if i-1 ~= 0
            %Ui,j-1
            A(matrix_row, (i-1-1)*N + j) = -1;
        end

        if i+1 ~= N+1
            %Ui,j+1
            A(matrix_row, (i+1-1)*N+j) = -1;
        end
        matrix_row  = matrix_row + 1;
    end
end
%exoume Ax = h^2 * G => A/h^2 x = G
A = A/h^2;%h^2
A = sparse(A);
U = ones(N^2,1);
G = A*U;
spy(A);

