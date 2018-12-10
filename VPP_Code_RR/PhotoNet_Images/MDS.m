
%Creates Figure 1 of the report
clear all

my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/PhotoNet_Images/'; %Sustitude with your own path

load(strcat(my_path,'features_train.mat'))
load(strcat(my_path,'labels_train.mat'))
dissimilarities = pdist(features_train);
[Y,stress,disparities] = mdscale(dissimilarities,2);
gscatter(Y(:,1),Y(:,2),labels_train)