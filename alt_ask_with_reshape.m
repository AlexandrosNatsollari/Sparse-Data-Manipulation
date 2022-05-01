% A = [
%      0 0 0 0 4 2 
%      0 0 1 1 2 2 
%      6 3 0 0 0 0 
%      3 0 0 0 0 0
%      2 1 0 0 2 1
%      1 1 0 0 1 1
%     ];
% 
% nb=2;
% [val,brow_idx,bcol_ptr]= sp_mx2bccs(A,nb)
% x   = [1; 1; 1; 1; 1; 1];
% y   = [0 0 0 0 0 0];


m=32;
n=64;
nb=m;
T=toeplitz([4,-1,zeros(1,m-2)]);
S=blkToeplitzTrid(n,inv(T),T^2,T);   
y=transpose(eye(n*m,1));
x=(ones(n*m,1));

y1 = y1+S*x;

[val,brow_idx,bcol_ptr]= sp_mx2bccs(S,nb);


%variable initializations

%square of given nb 
nbsq=nb*nb;
%start variable tells us where to start traversing val array 
start=1;
%x_mul variable tells us which row of x in A*x is currenly being multiplied
x_mul=1;
%n variable tells us how many times is main loop going to run based on the 
%block columns we have
n = length(bcol_ptr)-1;


length_of_associative=length(y);
associative_array=1:length_of_associative;


associative_array = mat2cell(associative_array,1, diff([0:nb:numel(associative_array)-1 numel(associative_array)]));

tic
%main loop
for j=1:n
    
    %With k1&k2 we get the position which block rows are this round's elements
    k1=bcol_ptr(j);
    k2=bcol_ptr(j+1)-1;
    %With m1&m2 we map the row in which this rounds elements would be
    %if we dint have block rows and have simple rows instead
    m1=cell2mat(associative_array(brow_idx(k1:k2)));
    
    %variable wich tells us how many non zero blocks there are in this
    %particular block column
    non_zero_column_blocks=abs(k2-k1)+1;

    
    %we get elements of this round's block column and transform them 
    %to a much desirable form in which x*A is easier to accomplish
    elements_of_block_column=val(start:start+(non_zero_column_blocks*nbsq)-1);
    temp_val=reshape(elements_of_block_column,nbsq,[]);
    block_sub_column=1;
 
    %for each sub-column of this block column we perform x(row)*A(sub-column)
    %then we add y+x(row)*A(sub-column)and store the result back to y in
    %proper positions
    for i=1:nb
        
        %get each sub-column's elements and perform x(row)*sub-column of
        %block column
        k=temp_val(block_sub_column:block_sub_column+nb-1,:);
        temp_A=reshape(k,1,[]);
        A_x=x(x_mul)*temp_A;
        
        y(m1)=y(m1)+A_x;
        
      
        
        block_sub_column=block_sub_column+nb;
        x_mul=x_mul+1;
    
    end
    
    %each time based on this block's non zero blocks we calculate the 
    %proper position in which the next traversing of val will begin
    start=start+(non_zero_column_blocks*nbsq);  

end
toc

rep = y;
norm_diff= norm(abs(y1-y))