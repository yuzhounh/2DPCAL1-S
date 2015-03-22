function acc=Classify_2DPCA(x_train,x_test,label_train,label_test)
% 2DPCA

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

d=size(x_train,1);
n_train=length(label_train);
n_test=length(label_test);

W=PCA2D(x_train);
nComp=size(W,2);
acc=zeros(nComp,1);

x_train_reserve=zeros(d,nComp,n_train);
for iSub=1:n_train
    x_train_reserve(:,:,iSub)=x_train(:,:,iSub)*W;
end

x_test_reserve=zeros(d,nComp,n_test);
for iSub=1:n_test
    x_test_reserve(:,:,iSub)=x_test(:,:,iSub)*W;
end

for iComp=1:nComp
    x_train=x_train_reserve(:,1:iComp,:);
    x_test=x_test_reserve(:,1:iComp,:);
    
    x_train=reshape(x_train,numel(x_train)/n_train,n_train);
    x_test=reshape(x_test,numel(x_test)/n_test,n_test);
    
    dxx=pdist2(x_train',x_test');
    [~,ix]=min(dxx);
    acc(iComp)=mean(label_test==label_train(ix));
end