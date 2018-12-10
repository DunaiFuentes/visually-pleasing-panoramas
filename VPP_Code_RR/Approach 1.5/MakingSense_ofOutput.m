my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/Panoramas2Classify_LowRes/'; %Change for your own

a = dir('*.prediction'); %Make sure it is in the working directory
format = '%f %f %f %f';
fileID = fopen(a.name);
output = textscan(fileID,format);
fclose(fileID);

%48 comes from 24x2 that is the number of cropped squares per pic
prob_clouds = output{1};
prob_sunset = output{2};
prob_night = output{3};
prob_sky = output{4};
numpics = length(prob_clouds)/48;

prob_clouds = reshape(prob_clouds,48,numpics);
prob_sunset = reshape(prob_sunset,48,numpics);
prob_night = reshape(prob_night,48,numpics);
prob_sky = reshape(prob_sky,48,numpics);

%Loop to decide which class it is
for i=1:numpics
    % First, we check against sunset and night because these two can
    % appear among clouds or plain skies. Then we check against clouds
    % because in the panorama there could well be cloudy zones
    pic_i_block = [prob_clouds(:,i) prob_sunset(:,i) prob_night(:,i) prob_sky(:,i)];
    [~,block_category] = max(pic_i_block');
    if (sum(block_category==2))>7      % If at least xxx blocks are most probably sunset
        type(i)=2;
    elseif (sum(block_category==3))>=20  % If at least xxx blocks are most probably night
        type(i)=3;
    elseif (sum(block_category==1))>=5  % If at least xxx blocks are most probably clouds
        type(i)=1;
    else
        type(i)=4;
    end
end

%print one class (1-4)
class = 2;
mylist = ls(strcat(my_path,'Raw/*.jpg'));
pic_format = strcat(my_path,'Raw/%s');
idx = type == class;
picname = mylist(idx,:);
for i=1:size(picname,1)
    pic = sprintf(pic_format,picname(i,:));
    figure()
    imshow(pic);
end
