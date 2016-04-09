function W=PCA2DL1S(x, lam, eta, ini_opt)
% Calculate the first k 2DPCAL1-S components.

%     2DPCA with L1-norm for simultaneously robust and sparse modelling
%     Copyright (C) 2013 Jing Wang
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

[~,width,p]=size(x); 
k=30;
W=zeros(width,k);

% different initializations
if nargin<4 
    ini_opt=1;      % default
end

if ini_opt==1       % corresponding components of 2DPCA
    cov=zeros(width);
    for i=1:p
        cov=cov+x(:,:,i)'*x(:,:,i);
    end
    [V,D]=eig(cov);
    [~,indx]=sort(diag(D),'descend'); 
    V=V(:,indx);
elseif ini_opt==2   % random maxtrix
    V=rand(width,k);
elseif ini_opt==3   % ones
    V=ones(width,k);
elseif ini_opt==4   % zeros
    V=zeros(width,k);
end

beta=zeros(width,1);
err_tol=1e-4;
for i=1:k
    stop=1;
    err=1;
    w=V(:,i);
    while stop
        for j=1:width
            if w(j)
                beta(j)=abs(w(j))/(lam+2*eta*abs(w(j)));
            else
                beta(j)=1/(2*eta);
            end
        end
        
        varpi=zeros(width,1);
        for j=1:p
            varpi=varpi+x(:,:,j)'*sign(x(:,:,j)*w);
        end
        
        w_new=beta.*varpi;
        w_new=w_new/norm(w_new);
        err=norm(w_new-w);
        
        if err>err_tol
            w=w_new;
        else 
            stop=0;
        end
    end

    for j=1:p
        x(:,:,j)=x(:,:,j)-x(:,:,j)*w*w';
    end
    W(:,i)=w;
end