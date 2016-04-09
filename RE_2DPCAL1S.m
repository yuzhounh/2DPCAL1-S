function err=RE_2DPCAL1S(x_noise,ix_noise,kSet,lam,eta,ini_opt)
% calculating the reconstruction error by 2DPCAL1-S
% x_noise is face images with noise
% the first 20% index of ix_noise are the index of images with noise
% select the first k features (projection vector)
% only count the differences between normal faces and their reconstruction

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
x_mean=mean(x_noise,3);
x_centered=x_noise-repmat(x_mean,[1,1,nSub]);
W=PCA2DL1S(x_centered,lam,eta, ini_opt);

% reconstruct the iSub-th image by the first iK-th components
nK=length(kSet);
xv_reco=zeros(size(x_noise));
err=zeros(nK,1);
tic;
for iK=1:nK
    w=W(:,1:kSet(iK));
    for iSub=1:nSub
        x_reco(:,:,iSub)=x_centered(:,:,iSub)*w*w'+x_mean;
    end
    temp=x_noise-x_reco(:,:,:);
    
    sum=0;
    for iSub=nSub/5+1:nSub % only count the differences of normal faces, not all. 1:165
        sum=sum+norm(temp(:,:,ix_noise(iSub)),'fro');
    end
    err(iK)=sum/(nSub/5*4); % there are (80%*n) faces calculated
    
    perct(toc,iK,nK);
end

figure;
plot(kSet,err,'-o');
title('RE\_2DPCAL1-S');
save('ERR_2DPCAL1S.mat','err');