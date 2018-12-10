% CROP & CREATE the 200x200 patches for classification.
my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/Panoramas2Classify_LowRes/'; %Sustitude with your own path
mylist = ls(strcat(my_path,'Raw/*.jpg'));
read_file_format = strcat(my_path,'Raw/%s');
write_file_format = strcat(my_path,'Processed/%d_%d_%s');
output_format = '%s\t%d\r\n';
cropsizeh = 200; %size can be modified
cropsizev = 200; %size can be modified
cropnh = floor(4821/cropsizeh);
cropnv = floor(400/cropsizev);

% Creates the test file (Classify.txt) for which we will generate the
% rankings of Approach 1.
% It is created in the working directory. It then has to be moved along
% with the proper CNTK files for Approach 1 to use it.
fileID = fopen('Classify.txt','w');
for i=1:size(mylist,1)
    working_image = sprintf(read_file_format,mylist(i,:));
    I = imread(working_image);
    for ii=0:cropnv-1
        for jj=0:cropnh-1
            cropped = imcrop(I,[jj*cropsizeh ii*cropsizev cropsizeh cropsizev]);
            saved_as = sprintf(write_file_format,ii,jj,mylist(i,:));
            imwrite(cropped,saved_as);
            fprintf(fileID,output_format,saved_as,0);
        end
    end
end
fclose(fileID);