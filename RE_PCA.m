function err=RE_PCA(x_noise,ix_noise,kSet)
% calculating the reconstruction error by PCA

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

nSub=size(x_noise,3);
xv_noise=reshape(x_noise,numel(x_noise)/nSub,nSub);   % reshape data as a vector
xv_mean=mean(xv_noise,2);
xv_centered=xv_noise-repmat(xv_mean,[1,nSub]);
W=PCA(xv_centered);

% reconstruct the iSub-th image by the first iK-th components
nK=length(kSet);
xv_reco=zeros(size(xv_noise));
err=zeros(nK,1);
tic;
for iK=1:nK
    w=W(:,1:kSet(iK));
    for iSub=1:nSub
        xv_reco(:,iSub)=w*w'*xv_centered(:,iSub)+xv_mean;
    end
    temp=xv_noise-xv_reco(:,:);
    
    sum=0;
    for iSub=nSub/5+1:nSub
        sum=sum+norm(temp(:,ix_noise(iSub))); 
    end
    err(iK)=sum/(nSub*4/5);
    
    perct(toc,iK,nK);
end

figure;
plot(kSet,err,'-o');
title('RE_PCA');
save('ERR_PCA.mat','err');