% Classify a face data by randomly selecting 10% subjects for testing and 
% using the remaining subjects for training. 

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

clear,clc;
face_name='Yale'; % AR, Feret, Yale
load(sprintf('%s.mat',face_name));

%% preprocess
% randomly separate samples
rng(0);
[height,width,n]=size(x); % number of samples
ix=randperm(n); % randomly separate the subjects
ix_test=ix(1:floor(n/10)); % 10% subjects for testing
ix_train=setdiff([1:n],ix_test); % the remaining subject for training

n_train=length(ix_train);
n_test=length(ix_test);

x_train=x(:,:,ix_train);
x_test=x(:,:,ix_test);

label_train=label(ix_train);
label_test=label(ix_test);

% display
figure;
montage(reshape(x_train,height,width,1,n_train),'DisplayRange',[]);
figure;
montage(reshape(x_test,height,width,1,n_test),'DisplayRange',[]);

% subtract the mean
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

save(sprintf('demo_classify_%s',face_name),'acc_pca','acc_pcal1','acc_2dpca','acc_2dpcal1',...
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
saveas(gcf,sprintf('demo_classify_%s',face_name),'epsc2');
saveas(gcf,sprintf('demo_classify_%s',face_name));
