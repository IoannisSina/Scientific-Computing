function [] = check_it()
    %we compare our multiplication and matlabs
    %matrices from suiteSparse
    %----------jagmesh4 1440x1440 id=179--------------------------------
    %----------ukerbe1_dual 1866x1866 id=2423---------------------------
    clc;
    for i= [179 2423]
        l = ssget(i);
        A = l.A;
        len = length(A);
        x = rand(len,1);
        y = rand(len,1);
        [val,col_idx,row_blk] = sp_mx2bcrs(A,2);
        my_y = spmv_bcrs(y,val,col_idx,row_blk,x);
        mat_y = y + A*x;
        fprintf("Error for matrix " + l.name +...
            " (%dx%d) is: %d.\n",len,len,norm(my_y-mat_y));
    end
end
   
    
   
    
 
    
    
    

