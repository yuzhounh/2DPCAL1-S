% Classify on AR data with natural occlusions, using the unoccluded images
% as training set and the occluded images as testing set

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

clear,clc;
load AR.mat;

%% preprocess
% separate samples, display, substract the mean, and reshape
n=size(x,3); % number of samples

ix_train=repmat([1:13:n]',1,7)+repmat([0:6],240,1);
ix_train=reshape(ix_train',numel(ix_train),1);
ix_test=setdiff([1:n]',ix_train);

n_train=length(ix_train);
n_test=length(ix_test);

x_train=x(:,:,ix_train);
x_test=x(:,:,ix_test);

label_train=kron([1:120]',ones(14,1));
label_test=kron([1:120]',ones(12,1));

% % check data
% figure;
% montage(reshape(x_train,50,40,1,1680),'DisplayRange',[]);
% figure;
% montage(reshape(x_test,50,40,1,1440),'DisplayRange',[]);

% substract the mean
x_train_mean=mean(x_train,3);
x_train=x_train-repmat(x_train_mean,[1,1,n_train]);
x_test=x_test-repmat(x_train_mean,[1,1,n_test]);

% for 1D algorithms, reshape each sample to a vector first
xv_train=reshape(x_train,numel(x_train)/n_train,n_train);
xv_test=reshape(x_test,numel(x_test)/n_test,n_test);

%% classify
acc_pca=Classify_PCA(xv_train,xv_test,label_train,label_test);
acc_pcal1=Classify_PCAL1(xv_train,xv_test,label_train,label_test);
acc_2dpca=Classify_2DPCA(x_train,x_test,label_train,label_test);
acc_2dpcal1=Classify_2DPCAL1(x_train,x_test,label_train,label_test);
acc_2dpcal1s=Classify_2DPCAL1S(x_train,x_test,label_train,label_test);

save('demo_classify_AR','acc_pca','acc_pcal1','acc_2dpca','acc_2dpcal1',...
    'acc_2dpcal1s');

%% plot
figure;
kSet=[1:30]';
plot(kSet,acc_pca,'-+',...
     kSet,acc_pcal1,'-s',...
     kSet,acc_2dpca,'-v',...
     kSet,acc_2dpcal1,'-*',...
     kSet,acc_2dpcal1s,'-o');
pos=get(gcf,'Position');
scale=1.2;
set(gcf,'Position',[pos(1),pos(2),pos(3)/scale,pos(4)/scale]);
legend('PCA','PCA-L1','2DPCA','2DPCA-L1','2DPCAL1-S','location','Southeast');
xlabel('Number of extracted basis vectors');
ylabel('Classification accuracy');
saveas(gcf,'demo_classify_AR','epsc2');
saveas(gcf,'demo_classify_AR');