function [val,col_idx,row_blk] = sp_mx2bcrs(A,nb)
    if mod(length(A),nb) ~= 0
        error("block size not correct");
    end
    
    if size(A,1) ~= size(A,2)
        error("Matrix must be square")
    end
    
    %val will be a cell array with k blocks (non zero blocks)
    %there will be length(A)/nb columns
    %and length(A)/nb + 1 rows
    length_A = length(A);
    num_of_rows =  length_A/nb;
    %initialization
    %------------------------------------------------------------
    val = {};
    col_idx = [];
    %the last pointer will point to the last element of val array
    row_blk = zeros(1, num_of_rows + 1);
    %------------------------------------------------------------
    rows = 1:nb:length_A;
    columns = 1:nb:length_A;
    %last value will be length(val)
    row_blk(1) = 1; %always one even if first row has 0 nnz blocks
    %so we start from second cell and we 
    row_blk_index = 2;
    for i=rows
        %how many nnz blocks the row has
        nnz_blocks_of_row = 0;
        current_column = 0;
        for j=columns
            current_column = current_column + 1;
            temp_block = A(i:nb+i-1, j:nb+j-1);
            if nnz(temp_block) ~= 0
                val{end+1} = temp_block;
                col_idx(end+1) = current_column;
                nnz_blocks_of_row = nnz_blocks_of_row + 1;
            end
            
        end
        row_blk(row_blk_index) = row_blk(row_blk_index -1) + ...
            nnz_blocks_of_row;
        row_blk_index = row_blk_index + 1;
    end
    

end