my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/Panoramas2Classify_LowRes/'; %Change for your own
rank_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/Rank/'; %Change for your own

%% Figure out the image ranking
a = dir('*.prediction'); % Has to be in the working directory!
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

[~,PicsRankIdx] = sort(AddedBeauty,'descend');

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


%% Top x + Bottom x coincidence with random rankings
number_of_random_rankings = 1000;
for ii=1:number_of_random_rankings
    x = 3; %This can be changed if a different evaluation is wanted.
    p = randperm(19);
    PicsRank2=PicsRank(p,:);
    for i = 1:size(a,1)
        rank = hrank{i};
        rank = rank{1};
        topx = PicsRank2(1:x,:);
        botx = PicsRank2(end-x+1:end,:);
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
        counts2(i) = count;
    end
    
    meancounts2(ii) = mean(counts2);
    user1counts2(ii) = counts2(1,1);
end

boxplot([meancounts2' user1counts2']);
random_mean_performance = mean(meancounts2);
random_oneuser_performance = mean(user1counts2);