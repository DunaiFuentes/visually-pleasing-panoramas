my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/Panoramas2Classify_LowRes/'; %Change for your own
rank_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/Rank/'; %Change for your own

%% Figure out the image ranking
a = dir('*.o2');
format = '%f';
fileID = fopen(a.name);
output = textscan(fileID,format);
fclose(fileID);

predicted_beautiness = output{1};
[~,PicsRankIdx] = sort(predicted_beautiness,'descend');

mylist = ls(strcat(my_path,'Raw/*.jpg'));
pic_format = strcat(my_path,'Raw/%s');

PicsRank = mylist(PicsRankIdx,:);

%% Load the human made rankings
a = dir(strcat(rank_path,'Rank*.txt'));
format = '%s';
for i = 1:size(a,1)
    file = sprintf(strcat(rank_path,'%s'),a(i).name);
    fileID = fopen(file);
    hrank{i} = textscan(fileID,format);
    fclose(fileID);
end

%% Top x + Bottom x coincidence
x = 3; %This can be changed if a different evaluation is wanted.
for i = 1:size(a,1)
    rank = hrank{i};
    rank = rank{1};
    topx = PicsRank(1:x,:);
    botx = PicsRank(end-x+1:end,:);
    count = 0;
    %top
    for j=1:x
        pic = topx(j,1:end-4); %-4 to eliminate the .jpg
        IndexC = strfind(rank, pic);
        Index = find(not(cellfun('isempty', IndexC)));
        if Index <= x
            count = count+1;
        end
    end
    %bottom
    for j=1:x
        pic = botx(j,1:end-4); %-4 to eliminate the .jpg
        IndexC = strfind(rank, pic);
        Index = find(not(cellfun('isempty', IndexC)));
        if Index > 19-x
            count = count+1;
        end
    end
    counts(i) = count;
end

meancounts = mean(counts);