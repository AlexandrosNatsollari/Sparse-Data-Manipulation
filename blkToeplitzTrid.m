function S=blkToeplitzTrid(n,B,A,C)
% Author : ALEXANDROS NATSOLLARI , AM:1057769 , Date : 21/11/2021

S = sparse(kron(eye(n),A) + kron(diag(ones(n-1,1), -1),B)+ kron(diag(ones(n-1,1), 1),C));

%full(S)
%spy(S);


end