% Load and display face data. Take the "yalefaces" as an example. 

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

% save .bmp to .mat
yale=[];
for i=1:15 % 15 subjects
    for j=1:11 % 11 images per subject
        yale(:,:,j,i)=imread(sprintf('yalefaces/%02d/s%d.bmp',i,j));
    end
end

% show the first image of each subject
figure;
montage(yale(:,:,1,:),'DisplayRange',[]);

% show all of the 11 images of the first subject
figure;
montage(reshape(yale(:,:,:,1),100,100,1,11),'DisplayRange',[]); 

% maybe in 3D data format
[height,width,nImage,nSub]=size(yale);
yale=reshape(yale,[height,width,nImage*nSub]);
