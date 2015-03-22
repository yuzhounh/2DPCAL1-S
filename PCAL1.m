function W=PCAL1(x)
% Calculate the first k PCA-L1 components.

%     2DPCA with L1-norm for simultaneously robust and sparse modelling
%     Copyright (C) <2013>  <Jing Wang>
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

[d,n]=size(x);
k=min(d,30);

% PCA-L1 is not sensitive to err_tol while PCAL1-S is.
err_tol=1e-4;
delta=1e-4;

% Initialize w as corresponding components of PCA. Other initialization 
% could be tried also.
[u0,~,~]=svd(x,0);
w=u0(:,1:k);

for i=1:k
    stop=1;
    while stop
        p=sign(x'*w(:,i)); 
        w_new=x*p;
        w_new=w_new/norm(w_new);
        err=norm(w_new-w(:,i));

        % convergence check
        if err>err_tol
            w(:,i)=w_new;
        elseif any(x'*w_new==0) % it's seldom satisfied
            w(:,i)=w_new+delta*rand(n,1);
            w(:,i)=w(:,i)/norm(w(:,i));
        else
            stop=0;
        end
    end
    x=x-w(:,i)*w(:,i)'*x;    % Greedy search algorithm
end
W=w;