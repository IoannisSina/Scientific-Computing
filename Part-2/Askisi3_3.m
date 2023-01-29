function [] = Askisi3_3(ten,length_of_path)
    %gia na vroume diadromes ews mhkous length_of_path apo olous pros olous
    %tous komvous, arkei apla na athrisoume ws pros mod 3 ola ta mhtrwa ews
    %diastash length_of_path. dhladh ten(:,:,1) + ten(:,:,2)... alla oxi
    %stoixeio pros stoixeio alla WS pros mod 3. Dhladh to stoixeio A(1,1)
    %toy telikoy apotelesmatow tha einai
    %A(1,1) = ten(1,1,1) + ten(1,1,2) + ten(1,1,3)...+ten(1,1,length_of_path)
    %leitoyrgei kai gia katefthinomena kai gia mh katefthinomena
    %Tha xrisimopoihsoyme thn collapse toy tensor toolbox 
    %phgh --> https://gitlab.com/tensors/tensor_toolbox/-/blob/master/@tensor/collapse.m
    addpath('tensor_toolbox');
    if length_of_path > size(ten,3)
        error("The longest path which can be calculated is up to %d",size...
            (ten,3));
    end
    result = collapse(ten(:,:,1:length_of_path),3);
    clc;
    fprintf("Number of paths up to length %d from node i to node j is A(i,j).\n",length_of_path);
    disp("Matrix A is:");
    disp(double(result));
    
end