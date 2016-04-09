% Reconstruction with five different algorithms

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

clear,clc,close all;
load Feret_noise.mat;

kSet=[1:30]; % the number of features extracted

% parameters for 2DPCAL1-S
lam=1;
eta=1e3;
ini_opt=1;

x1=RE_PCA(x_noise,ix_noise,kSet);
x2=RE_PCAL1(x_noise,ix_noise,kSet);
x3=RE_2DPCA(x_noise,ix_noise,kSet);
x4=RE_2DPCAL1(x_noise,ix_noise,kSet);
x5=RE_2DPCAL1S(x_noise,ix_noise,kSet,lam,eta,ini_opt);

figure;
plot(kSet,x1,'-r.',...
     kSet,x2,'-g*',...
     kSet,x3,'-r*',...
     kSet,x4,'-g.',...
     kSet,x5,'-bo');
legend('PCA','PCA-L1','2DPCA','2DPCA-L1','2DPCAL1-S','location','Northeast');
xlabel('Number of extracted features');
ylabel('Average reconstruction error');
saveas(gcf,'RE_5M.fig');