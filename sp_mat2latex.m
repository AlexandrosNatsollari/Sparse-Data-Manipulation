function [val,row_ip,col_ip]= sp_mat2latex(A,sp_type)
% Author : ALEXANDROS NATSOLLARI , AM:1057769 , Date : 17/11/2021


    %open file to write the results,it can be whatever type.In this case
    %its a txt file.
    fid = fopen('sp_mat2latex.txt', 'w');
     
    %%%%%%%%%%%%%%%%%%%%%%%% val creation %%%%%%%%%%%%%%%%%%%%%%%%
  
    %In order for val to have the proper size each time based on the 
    %given matrix we calculate nonzeros of given matrix and create 
    %val = \\begin{tabular}{|l|l....|l|}\\hline based on that.
    k = nnz(A);
    val= zeros(1:k);%preallocation of val.
    val_str2 = zeros(1:k);  
    val_str1 = '$$val= \begin{tabular}{|';
    val_str2 = repmat('l|', 1, k); %repmat is used instead of for loop.
    val_str3 = '}\hline';
    final_val_str = [val_str1 val_str2 val_str3];
    %The first  Latex line to be printed to file, is printed later to 
    %to the file along with all the other lines in order to reduce 
    %writing delays.

%Checking if sp_type is csr or csc. 
if  strcmp(sp_type,'csr')
   
    [rows, columns] = size(A);
    CurrentRow = 1;
    
    %preallocation of NonZero Elements.
    NonZeroElements = {1:k};
    
    %preallocation of row_ptr.
    row_ptr = (1:rows+1);
    
    %We store nonzero elements of each line (since we are in csr sp_type) 
    %cells.
    for i = 1:rows
        
        j=i+1;
        thisRow = A(i, :);
        nonzero = thisRow(thisRow ~= 0);
           
        %Calculating row_ptr/JA.
        row_ptr(1)= 1;
        row_ptr(j)= numel(nonzero) + row_ptr(i);
        
        %Store nonzero elements.
        if ~isempty(nonzero)
            NonZeroElements{CurrentRow} = nonzero;
            CurrentRow = CurrentRow+1;
            
        end
        
    end


    %Converting cell arrays to matrix and then from double matrix to 
    %string in order to add & to desired numbers.
    val = cell2mat(NonZeroElements);
    
    %Split first element from others temporarly so it doesn't get the &
    %like the others will.
    col_idx_temp1 = val(1,1);
    col_idx_tempstr1 = num2str(col_idx_temp1);
    col_idx_temp2 = val(1,2:end);
    col_idx_tempstr2 = string(col_idx_temp2);

    %All elements from 2:end get & in front of them.
    tempstr2_final = strcat('&',col_idx_tempstr2);

    
    %%%%%%%%%%% Writing latex code for val to the file %%%%%%%%%%%
    fprintf(fid,'%s\n',final_val_str);
    fprintf(fid,' %s %s',col_idx_tempstr1,tempstr2_final); 
    fprintf(fid," \\\\ \\hline\n");
    fprintf(fid,"\\end{tabular}$$\n");
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%% col_idx/IA creation %%%%%%%%%%%%%%%%%%%%%%%%
    col_idx_str2 = zeros(1:k);
    
    col_idx_str1 = '$$IA= \begin{tabular}{|';
    %repmat is used instead of for loop.
    col_idx_str2 = repmat('l|', 1, k); 
    col_idx_str3 = '}\hline';
    final_col_idx_str = [col_idx_str1 col_idx_str2 col_idx_str3];
    
    %Storing transpose A in sparse type in order to deal only 
    %with nonzero elements.
    x=sparse(transpose(A));

    [row2, columns2]=find(x);
    
    %Storing column in wich the element is in original matrix, thus
    %creating col_idx/IA vector to be printed to file.
    col_idx = transpose(row2);
    
    %Split first element from others temporarly so it doesn't get the &
    %like the others will.
    col_idx_temp1 = col_idx(1,1);
    col_idx_tempstr1 = num2str(col_idx_temp1);
    col_idx_temp2 = col_idx(1,2:end);
    col_idx_tempstr2 = string(col_idx_temp2);
    
    %All elements from 2:end get & in front of them.
    tempstr2_final = strcat('&',col_idx_tempstr2);
    

    
    %%%%%%%%%%% Writing latex code for col_idx to the file %%%%%%%%%%%
    fprintf(fid,"%s\n",final_col_idx_str);
    fprintf(fid,' %s %s',col_idx_tempstr1,tempstr2_final); 
    fprintf(fid," \\\\ \\hline\n");
    fprintf(fid,"\\end{tabular}$$\n");
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%% row_ptr/JA creation %%%%%%%%%%%%%%%%%%%%%%%%
    row_ptr_str2 = zeros(1:k);
    
    row_ptr_str1 = '$$JA= \begin{tabular}{|';
    %repmat is used instead of for loop.
    row_ptr_str2 = repmat('l|', 1, k); 
    row_ptr_str3 = '}\hline';
    final_row_ptr_str = [row_ptr_str1 row_ptr_str2 row_ptr_str3];
    

    %Split first element from others temporarly so it doesn't get the &
    %like the others will.
    row_ptr_temp1 = row_ptr(1,1);
    row_ptr_tempstr1 = num2str(row_ptr_temp1);
    row_ptr_temp2 = row_ptr(1,2:end);
    row_ptr_tempstr2 = string(row_ptr_temp2);
    
    %All elements from 2:end get & in front of them.
    tempstr2_final = strcat('&',row_ptr_tempstr2);
    

    
    %%%%%%%%%%% Writing latex code for row_ptr to the file %%%%%%%%%%%
    fprintf(fid,"%s\n",final_row_ptr_str);
    fprintf(fid,' %s %s',row_ptr_tempstr1,tempstr2_final);
    fprintf(fid," \\\\ \\hline\n");
    fprintf(fid,"\\end{tabular}$$\n");
    
    %saving IA to col_ip and JA to row_ip and closing file.
    row_ip = row_ptr;
    col_ip = col_idx;
    fclose(fid);
    
end

%Same as before but for 'csc' type this time
if  strcmp(sp_type,'csc')
   
    fid = fopen('sp_mat2latex.txt', 'w');
    val=(1:k);%preallocation of val
    
    %%%%%%%%%%%%%%%%%%%%%%%% val creation %%%%%%%%%%%%%%%%%%%%%%%%
    
    [rows, columns] = size(A);
    CurrentColumn = 1;
    
    %preallocation of NonZero Elements
    NonZeroElements = {1:k};
    
    %preallocation of col_ptr
    col_ptr = (1:columns+1);
    
    %We store nonzero elements of each column (since we 
    %are in csc sp_type)to cells.
    for i = 1:columns
        j=i+1;
        thisColumn = A(:, i);
        nonzero = thisColumn(thisColumn ~= 0);
           
        %Calculate col_ptr/JA
        col_ptr(1)= 1;
        col_ptr(j)= numel(nonzero) + col_ptr(i);
        
        %Store nonzero elements.
        if ~isempty(nonzero)
            
            %We need nonzero' in order cell2mat to work properly.
            NonZeroElements{CurrentColumn} = nonzero';
            CurrentColumn = CurrentColumn+1;
            
            
        end
        
    end


    %Converting cell arrays to matrix and then from double matrix 
    %to string in order to add & to desired numbers.
    val = cell2mat(NonZeroElements);

    %Split first element from others temporarly so it doesn't get the &
    %like the others will.
    row_idx_temp1 = val(1,1);
    row_idx_tempstr1 = num2str(row_idx_temp1);
    row_idx_temp2 = val(1,2:end);
    row_idx_tempstr2 = string(row_idx_temp2);
    
    %All elements from 2:end get & in front of them.
    tempstr2_final = strcat('&',row_idx_tempstr2);

    
    %%%%%%%%%%% Writing latex code for val to the file %%%%%%%%%%%
    fprintf(fid,'%s\n',final_val_str);
    fprintf(fid,' %s %s',row_idx_tempstr1,tempstr2_final); 
    fprintf(fid," \\\\ \\hline\n");
    fprintf(fid,"\\end{tabular}$$\n");
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%% row_idx/IA creation %%%%%%%%%%%%%%%%%%%%%%%%
    row_idx_str2 = [];
    row_idx_str1 = '$$IA= \begin{tabular}{|';
    %repmat is used instead of for loop.
    row_idx_str2 = repmat('l|', 1, k); 
    row_idx_str3 = '}\hline';
    final_row_idx_str = [row_idx_str1 row_idx_str2 row_idx_str3];
    
    %Storing A in sparse type in order to deal only with 
    %nonzero elements.
    x=sparse(A);

    [row2, columns2]=find(x);

    row_idx = row2';
    %Split first element from others temporarly so it doesn't get the &
    %like the others will.
    row_idx_temp1 = row_idx(1,1);
    row_idx_tempstr1 = num2str(row_idx_temp1);
    row_idx_temp2 = row_idx(1,2:end);
    row_idx_tempstr2 = string(row_idx_temp2);
    
    %All elements from 2:end get & in front of them.
    tempstr2_final = strcat('&',row_idx_tempstr2);
    

    
    %%%%%%%%%%% Writing latex code for row_idx/IA to the file %%%%%%%%%%%
    fprintf(fid,"%s\n",final_row_idx_str);
    fprintf(fid,' %s %s',row_idx_tempstr1,tempstr2_final);
    fprintf(fid," \\\\ \\hline\n");
    fprintf(fid,"\\end{tabular}$$\n");
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%% col_ptr/JA creation %%%%%%%%%%%%%%%%%%%%%%%%
    col_ptr_str2 = [];
    col_ptr_str1 = '$$JA= \begin{tabular}{|';
    %repmat is used instead of for loop.
    col_ptr_str2 = repmat('l|', 1, k); 
    col_ptr_str3 = '}\hline';
    final_col_ptr_str = [col_ptr_str1 col_ptr_str2 col_ptr_str3];
    

    %Split first element from others temporarly so it doesn't get the &
    %like the others will.
    col_ptr_temp1 = col_ptr(1,1);
    col_ptr_tempstr1 = num2str(col_ptr_temp1);
    col_ptr_temp2 = col_ptr(1,2:end);
    col_ptr_tempstr2 = string(col_ptr_temp2);
    
    %All elements from 2:end get & in front of them.
    tempstr2_final = strcat('&',col_ptr_tempstr2);
    

    
    %%%%%%%%%%% Writing latex code for col_ptr/JA to the file %%%%%%%%%%%
    fprintf(fid,"%s\n",final_col_ptr_str);
    fprintf(fid,' %s %s',col_ptr_tempstr1,tempstr2_final); 
    fprintf(fid," \\\\ \\hline\n");
    fprintf(fid,"\\end{tabular}$$\n");
    
    %saving IA to row_ip and JA to column_ip and closing file.
    row_ip = row_idx;
    col_ip = col_ptr;
    fclose(fid);
    
end 


if  strcmp(sp_type,'csr') ~= 1 && strcmp(sp_type,'csc') ~= 1 
    fprintf('Worng type of sparse matrix.\n');
end



end