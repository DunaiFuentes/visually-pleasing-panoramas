%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script creates the Train.txt and Test.txt files from Photo.net
% dataset. It downloads the images to working directory.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% READING PHOTONET FILE
my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/PhotoNet_Images/'; %Sustitude with your own path
fileID = fopen(strcat(my_path,'0_photonet_dataset.txt'));
formatSpec = '%d %d %d %f %f %f %f %f %f %f %f %f';
sizeA = [12 Inf];
A = fscanf(fileID,formatSpec,sizeA)';
fclose(fileID);

idx = A(:,2);

score = A(:,4);

%% DOWNLOADING IMAGES                ---> I read till 11004! Stop when you feel like. Only 1200 first needed.
    filename_format = '%d.jpg';
for i = 1:length(idx)
    id = idx(i);
    url_format = 'http://gallery.photo.net/photo/%d-md.jpg';
    url = sprintf(url_format,id);
    filename = sprintf(filename_format,id);
    try
        outfilename = websave(filename,url);
        i %to know where u are
    catch
        warning('prob here')
        score(i)=[];
    end
end


%% Generating Files

mylist = dir('*jpg'); %Note that it matches with the order in the dataset file
score2 = score(1:1200); %We only used the 1200 first images!
mean_score = mean(score2);
label_provisional = score2 >= mean_score;

% This other approach is also of interest:
%label_to_1 = score2 > (mean_score+1);
%label_to_0 = score2 < (mean_score-1); 

% WRITE Train FILE
fileID = fopen('Train.txt','w');
format_list = strcat(my_path,'%s\t%d\r\n');
for i = 1:1000
    fprintf(fileID,format_list,mylist(i).name,label_provisional(i));
end
fclose(fileID);

% WRITE Test FILE
fileID = fopen('Test.txt','w');
format_list = strcat(my_path,'%s\t%d\r\n');
for i = 1001:1200
    fprintf(fileID,format_list,mylist(i).name,label_provisional(i));
end
fclose(fileID);