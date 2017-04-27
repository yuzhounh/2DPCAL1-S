% the main script
% 2017-4-21 08:46:25

clear,clc,close all;

unzip('yalefaces.zip'); % uncompress the Yale data
demo_load_data;
demo_classification;
demo_add_noise;
demo_reconstruction;
