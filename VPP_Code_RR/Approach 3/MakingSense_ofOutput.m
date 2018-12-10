% Visualize the generated ranking

my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/Panoramas2Classify_LowRes/'; %Change for your own

a = dir('*.o2'); %Make sure the file is in the working directory (generated or imported)
format = '%f';
fileID = fopen(a.name);
output = textscan(fileID,format);
fclose(fileID);

predicted_beautiness = output{1};
[~,PicsRankIdx] = sort(predicted_beautiness);

mylist = ls(strcat(my_path,'Raw/*.jpg'));
pic_format = strcat(my_path,'Raw/%s');

PicsRank = mylist(PicsRankIdx,:);
for i=1:length(predicted_beautiness)
    pic = sprintf(pic_format,PicsRank(i,:));
    figure()
    imshow(pic);
end

