function [y]= spmv_bcrs(y,val,col_idx,row_blk,x)
    
    %find size of A and check if multiplication is feasible
    %we know that row_blk has length of block rows of A +1 
    %so if we subtract 1 and multiply by blovk size we have 
    %As number of rows. Since A is square we have columns as well

    nb = length(val{end});
    row_blk_length = length(row_blk);
    size_A = (row_blk_length - 1) * nb;
    if size_A ~= size(x,1) || size_A ~= size(y,1)
        error("Rows of y must be as many as A's columns");
    end
    
    
    for i=1:row_blk_length-1
        nnz_blocks_of_row = row_blk(i+1) - row_blk(i);
        %beginning from val(row_blk(i)) to  + nnz_blocks_of_row - 1
        %first block row. i=1 -> real start =1 nb=2
        %third block 3-1 * 2 +1 = 5..
        real_row_start = (i-1)*nb + 1;
        %for each block of row i
        for j = row_blk(i): row_blk(i) + nnz_blocks_of_row - 1
            temp_block = val{j};
            real_column_start = (col_idx(j) -1)*nb + 1;
            %for each row of block multiply it with right xs sub vector
            %if we are in row 3 and nb=3 and we are at 4th column
            %the multipltication looks like this: y(3:5) = y(3:5) + 
            %temp_block * x(3:5)
            y(real_row_start:real_row_start+nb-1) = y(real_row_start:real_row_start+nb-1) + temp_block*...
                x(real_column_start:real_column_start+nb-1);
        end
    end
    
    %with full multiplication we would have 
end