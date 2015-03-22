function W=PCA2D(x)
% Calculate the first k components of 2DPCA

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

[~,width,p]=size(x); 
cov=zeros(width);
for i=1:p
    cov=cov+x(:,:,i)'*x(:,:,i);
end
[V,D]=eig(cov);

% Sort the eigen values in order.
[~,indx]=sort(abs(diag(D)),'descend');
V=V(:,indx);

k=30;
W=V(:,1:k);