my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/MirFlickr_Images/'; %Sustitude with your own path


%% EXTRACTING TAGS
mylist = ls(strcat(my_path,'25k_meta/tags/tags*.txt'));
file_format = strcat(my_path,'25k_meta/tags/tags%d.txt');

formatSpec = '%s';

for i = 1:length(mylist)
    filename = sprintf(file_format,i);
    fileID = fopen(filename);
    C = textscan(fileID,formatSpec);
    A{i} = C{1,1};
    fclose(fileID);
end

%% SELECTING IMAGES WITH DESIRED TAGS
idx0=1;
idx1=1;
idx2=1;
idx3=1;
for i = 1:length(mylist)
    aux = A{i};
    for j = 1:size(aux,1)
        tag = aux{j};
        switch tag
            case 'clouds'
                idclouds(idx0) = i;
                idx0 = idx0+1;
            case 'sunset'
                idsunset(idx1) = i; 
                idx1 = idx1+1;
%             case 'sunrise'
%                 idsunrise(idx2) = i; 
%                 idx2 = idx2+1;

            case 'night'    % An ugly change to ignore sunrises because of too few examples and get night instead
                idsunrise(idx2) = i; 
                idx2 = idx2+1;

            case 'sky'
                idsky(idx3) = i;
                idx3 = idx3+1;
        end
    end
end  

%% WRITE TRAIN AND TEST FILES

% A quick selection of sizes to deal with unbalance quantities of images:
n_samples = min([length(idsunset) length(idclouds) length(idsunrise) length(idsky)]);

% total_images = length(idsunset) + length(idclouds) + length(idsunrise) + length(idsky);
proportion_train=0.8;

n_train_samples = floor(n_samples*proportion_train);

% Train
fileID_train = fopen('Train.txt','w');
format_list = strcat(my_path,'25k_images/im%d.jpg\t%d\r\n');
for i = 1:n_train_samples
    fprintf(fileID_train,format_list,idclouds(i),0);  %class 0
    fprintf(fileID_train,format_list,idsunset(i),1); %class 1
    fprintf(fileID_train,format_list,idsunrise(i),2); %class 2
    fprintf(fileID_train,format_list,idsky(i),3); %class 3
end
fclose(fileID_train);

%Test
fileID_test = fopen('Test.txt','w');
for i = n_train_samples+1:n_samples
    fprintf(fileID_train,format_list,idclouds(i),0);  %class 0
    fprintf(fileID_train,format_list,idsunset(i),1); %class 1
    fprintf(fileID_train,format_list,idsunrise(i),2); %class 2
    fprintf(fileID_train,format_list,idsky(i),3); %class 3
end
fclose(fileID_test);