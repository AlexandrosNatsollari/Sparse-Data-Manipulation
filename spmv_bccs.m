function [y]= spmv_bccs(y,x,nb,val,brow_idx,bcol_ptr)
% Author : ALEXANDROS NATSOLLARI


%check if y,x have the right dimensions in odrer the function to run
%properly, if not then transpose the vectors accordingly.
[dim1, dim2]=size(y);
[dim3, dim4]=size(x);

if (dim1 ~= 1 && dim2 == 1)
    
    y=transpose(y);
    
elseif (dim4 ~= 1 && dim3 == 1)
    
    x=transpose(x);
    
end

%Variable Initializations.

%Variable z is a counter that serves the purpose of multiplying each time 
%the correct row of x vector with the correct column of A.
z=1;

%Variable start marks the proper position in which val vector will be
%traversed each time based on the last traverse.
start=1;

%length_of_associative is a variable that stores the length of vector y.
length_of_associative=length(y);
%astive is sort for associative.
astive=1:length_of_associative;

%associative_array is an array that given the block rows of block matrix
%and the size of block creates a cell array that asscociates the block row
%mumber with the row number that rows would have in the original matrix.
astive = mat2cell(astive,1, diff([0:nb:numel(astive)-1 numel(astive)]));


%simple variable that determines how many times will the main loop run
%based on the length of vector bcol_ptr.
loop_times = length(bcol_ptr)-1;

%main loop.
for j=1:loop_times
    
    %k1 and k2 variables point the block column in which this rounds block
    %elements are.
    k1=bcol_ptr(j);
    k2=bcol_ptr(j+1)-1;
   
    %m1 variable given the block column of this rounds block elements
    %calculates the rows associated with the block rows.
    m1=cell2mat(astive(brow_idx(k1:k2)));
    
    %non_zero_blocks stores the number of non zero blocks of this round.
    non_zero_blocks =(k2-k1)+1;
    
    %Variable h is a simple counter so x(row)*A(column) is stored in proper
    %position of y.
    h=1;

   %With this loop we traverse all block elements of this round.
   for k=1:non_zero_blocks
        
        %With this loop we calculate x(row)*A(column), add it with the next
        %x(row)*A(column) in line, so all sub-columns of block column 
        %are multiplied with the proper x(row) and then added together.
        for p=1:nb
            
            y(m1(h:(h+nb)-1)) = y(m1(h:(h+nb)-1)) + x(z)*val(start:(start+nb)-1);
            
            start=start+nb;
            
            z=z+1;
            
        end
        
        h=h+nb;
        
        z=1;
   end
   
   z=j+nb-1;
   
end
%y
end
