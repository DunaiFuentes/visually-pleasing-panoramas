% This was to prepare train and test files for CNTK with the handcrafted
% features approach.

clear all

my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/PhotoNet_Images/'; %Sustitude with your own path

load(strcat(my_path,'features_train'));
load(strcat(my_path,'features_test'));
load(strcat(my_path,'labels_train'));
load(strcat(my_path,'labels_test'));

%% Write Train2.txt file
fileID = fopen('Train2.txt','w');
format_list = '%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\r\n';
for i = 1:length(features_train)
    fprintf(fileID,format_list,labels_train(i),[features_train(i,:)]);
end
fclose(fileID);

%% Write Test2.txt file
fileID = fopen('Test2.txt','w');
format_list = '%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\r\n';
for i = 1:length(features_test)
    fprintf(fileID,format_list,labels_test(i),[features_test(i,:)]);
end
fclose(fileID);