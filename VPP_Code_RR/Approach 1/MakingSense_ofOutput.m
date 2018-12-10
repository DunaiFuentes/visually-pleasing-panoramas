% Visualize the generated ranking

my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/Panoramas2Classify_LowRes/'; %Change for your own

a = dir('*.prediction'); %Make sure it is in the working directory
format = '%f %f';
fileID = fopen(a.name);
output = textscan(fileID,format);
fclose(fileID);
%48 comes from 24x2 that is the number of cropped squares per pic

prob_beauty = output{2};
numpics = length(prob_beauty)/48;

prob_beauty2 = reshape(prob_beauty,48,numpics);
prob_beauty3 = sort(prob_beauty2);
%We are only gonna use the top 8 cropped squares because humans focus on
%the "good part" of the panorama.
prob_beauty4 = prob_beauty3(41:end,:);
AddedBeauty = sum(prob_beauty4);

[~,PicsRankIdx] = sort(AddedBeauty);

mylist = ls(strcat(my_path,'Raw/*.jpg'));
pic_format = strcat(my_path,'Raw/%s');

PicsRank = mylist(PicsRankIdx,:);


for i=1:numpics
    figure
    pic = sprintf(pic_format,PicsRank(i,:));
    imshow(pic);
end

