function [] = Askisi3_2(ten,length_of_path,node_1,node_2)
    addpath('tensor_toolbox');
    %tha exoume K mhtrwa. Estw oti theloume tis diadromes mhkous ws K apo
    %ton komvo i ston j. Prepei na athrisoume ta stoixeia i,j olwn twn
    %epimerouw mhtrwwn. Synemws mporoume na paroume ksediplwsoume ton
    %tanysth ws pros mod 3 kai na atrhisoyme thn katallhlh sthlh toy
    %apotelesmatos h opia tha einai..
    %to parapanw leitourgei kai gia katefthinomena kai gia mh
    %katefthinomena grafhmata
    num_of_nodes = size(ten,2);
    if node_1 > num_of_nodes || node_2 > num_of_nodes
        error("No such Node. Nodes are from %d to %d",1,num_of_nodes);
    end
    
    if length_of_path > size(ten,3)
        error("The longest path which can be calculated is up to %d",size...
            (ten,3));
    end
    %an theloume apo diadromes mikous length_of_path apo ton komvo 3 ston 5
    %pairnoume to mod 3 toy tanisth kai h sthlh toy apotelesmatos poy
    %antiprosopevei to zhtoumeno tha einai h (j-1)*N + i. Dhladh edv tha
    %einai 4*5 + 3 = 23. Apo thn sthlh tha atrhizoume mexri to
    %length_of_path stoixeio. Gia mh katefthinomena oi diadromew apo node_1
    %pros node_2 kai apo node_2 pros node_1 tha einai idies afoy exoume
    %simetrika mhtrwa
    ten_3 = tenmat(ten,3);
    %node_1 to node_2
    all_from_node_1_to_node_2 = ten_3(:,(node_2-1)*num_of_nodes + node_1);
    all_from_node_2_to_node_1 = ten_3(:,(node_1-1)*num_of_nodes + node_2);
    
    clc;
    fprintf("Number of paths from node %d to node %d up to length %d: %d.\n",node_1,node_2...
        ,length_of_path,sum(all_from_node_1_to_node_2(1:length_of_path)));
    
    fprintf("Number of paths from node %d to node %d up to length %d: %d.\n",node_2,node_1...
    ,length_of_path,sum(all_from_node_2_to_node_1(1:length_of_path)));
    
end