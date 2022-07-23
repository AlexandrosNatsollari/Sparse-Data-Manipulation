function S=blkToeplitzTrid(n,B,A,C)
% Author : ALEXANDROS NATSOLLARI 
S = sparse(kron(eye(n),A) + kron(diag(ones(n-1,1), -1),B)+ kron(diag(ones(n-1,1), 1),C));

%full(S)
%spy(S);


end
