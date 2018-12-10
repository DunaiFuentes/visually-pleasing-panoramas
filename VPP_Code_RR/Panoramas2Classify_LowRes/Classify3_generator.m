% Creates the test file (Classify3.txt) for which we will generate the
% rankings of Approach 3.
% It is created in the working directory. It then has to be moved along
% with the proper CNTK files for Approach 3 to use it.

my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/Panoramas2Classify_LowRes/'; %Sustitude with your own path
mylist = ls(strcat(my_path,'Raw/*.jpg'));
output_format = strcat(my_path,'Raw/%s\t0\r\n'); 
%note that we write a label '0' that doesn't have any effect. It's just to
%respect the reader's structure.

fileID = fopen('Classify3.txt','w');
for i=1:size(mylist,1)
     fprintf(fileID,output_format,mylist(i,:));
end
fclose(fileID);