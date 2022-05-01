clc
clear

%%%%%%%%%%%%%%%%%%%%%%%CSR%%%%%%%%%%%%%%%%%%%%%%%%%
% A=[1 0 2; 3 4 0; 0 0 1]
% 
% [rows,cols]=size(A);
% first_elem=true;

% w=1;
% p=1;
% nonzero_row_elems=0;
% 
% for i=1:rows
%     
%     for j=1:cols
%         
%         if A(i,j) ~=0
%             
%             val(p)=A(i,j);
% 
%             col_idx(p)=j;
%             p=p+1;
%          
%             nonzero_row_elems=nonzero_row_elems+1;
%             
%             if first_elem==true
%                 row_ptr(w)=nonzero_row_elems;
%                 w=w+1;
%                 first_elem=false;
%             end 
%             
%             
%         
%         end
%         
%         
%         
%     end 
%    first_elem=true;
%    
% end 
% 
% x=numel(val)+1
% y=numel(row_ptr)+1
% 
% row_ptr(y)=x;
% 
% val
% col_idx
% row_ptr

%%%%%%%%%%%%%%%%%%%%%%%SPMM_CSR%%%%%%%%%%%%%%%%%%%%%%%%%
% A=[
%      0 -1  0 0
%     -1  0 -1 0
%      0 -1  0 1
%      0  0  1 2
%      ]
%  
%  W=[
%      1 2   3  4
%      5 6   7  8
%      9 10  11 12
%      13 14 15 16
%      ]
%  
% %  val=[-1 -1 -1 -1 1 1 2];
% %  JA=[ 2 1 3 2 4 3 4];
% %  IA=[ 1 2 4 6 8];
% 
%   val=[-1 -1 -1 -1 1 1 2];
%   JA=[ 2 1 3 2 4 3 4];
%   IA=[ 1 2 4 6 8];
%  
%  REAL=A*W;
%  
%  n=length(IA)-1;
%  
%  for j=1:n
%      
%      k1=IA(j);
%      k2=IA(j+1)-1;
%      
%      for i=1:n
%          
%          C(j,i)=val(k1:k2)*W(JA(k1:k2),i)
%           
%      end
%      
%  end
%  REAL


%%%%%%%%%%%%%%%%%%%%%%%CSC%%%%%%%%%%%%%%%%%%%%%%%%%
% A=[1 0 2; 3 4 0; 0 0 1]
% 
% [rows,cols]=size(A);
% first_elem=true;
% 
% w=1;
% p=1;
% nonzero_col_elems=0;
% 
% for i=1:cols
%     
%     for j=1:rows
%         
%         if A(j,i) ~=0
%             
%             val(p)=A(j,i);
% 
%             row_idx(p)=j;
%             p=p+1;
%          
%             nonzero_col_elems=nonzero_col_elems+1;
%             
%             if first_elem==true
%                 col_ptr(w)=nonzero_col_elems;
%                 w=w+1;
%                 first_elem=false;
%             end 
%             
%             
%         
%         end
%         
%         
%         
%     end 
%    first_elem=true;
%    
% end 
% 
% x=numel(val)+1
% y=numel(col_ptr)+1
% 
% col_ptr(y)=x;
% 
% val
% row_idx
% col_ptr

%%%%%%%%%%%%%%%%%%%%%%%CSC%%%%%%%%%%%%%%%%%%%%%%%%%
% A=[
%      1 3 0 0
%      2 0 1 0
%      0 5 0 1
%      0 0 1 2
%      ];
%  
%  B=[
%      1 2   3  4
%      5 6   7  8
%      9 10  11 12
%      13 14 15 16
%      ];
%  
% 
% 
% val=[1 2 3 5 1 1 1 2];
% JA=[ 1 2 1 3 2 4 3 4];
% IA=[ 1 3 5 7 9];
% C=zeros(4);
% 
% % for p=1:4
% %     p
% %     A(:,p)
% %     B(p,:)
% %     C=C+A(:,p)*B(p,:)
% %     
% % end
% 
%  REAL=A*B;
%  
%  n=length(IA)-1;
%  
%  for j=1:n
%      
%      k1=IA(j)
%      k2=IA(j+1)-1
%      
%     
%         val(:,k1:k2)'
%         B(j,:)
%         C(JA(k1:k2),:)=C(JA(k1:k2),:)+val(:,k1:k2)'.*B(j,:)
%          
%      
%  end
% REAL