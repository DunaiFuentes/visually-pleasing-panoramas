% To create Train5.txt and Test5.txt files

my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/Panoramas2Classify_Crawler/';
load('list_with_scores');

j=1;
for i=1:1200 %I rated 1200 pics
    I = imread(sprintf(strcat(my_path,'Raw/%s'),list(i).name));
    aux = size(I); %We are gonna check that the size of the image is right
    % because it is going to be very important for
    % the neural network and I noticed while evaluating that some of the
    % images had been wrongly downloaded.
    
    if ((aux(1)==400)&&(aux(2)==4821))
        list_of_names{j} = list(i).name;
        list_of_scores(j) = list(i).score;
        j = j+1;
    end
end

% Reestructuring of the labels
new_scores = list_of_scores;
new_scores(list_of_scores==1)=0;
new_scores(list_of_scores==2)=0;
new_scores(list_of_scores==3)=1;
new_scores(list_of_scores==4)=2;
new_scores(list_of_scores==6)=3;
new_scores(list_of_scores==7)=3;
new_scores(list_of_scores==8)=3;
new_scores(list_of_scores==9)=3;
new_scores(list_of_scores==5)=[];
hist(new_scores)

new_names = list_of_names;
new_names(list_of_scores==5)=[];

fileID = fopen('Train5.txt','w');
format_list = strcat(my_path,'Raw/%s\t%d\r\n');
for i=1:900
    fprintf(fileID,format_list,new_names{i},new_scores(i));
end
fclose(fileID);

fileID = fopen('Test5.txt','w');
format_list = strcat(my_path,'Raw/%s\t%d\r\n');
for i=901:length(new_scores) %Around 100 samples
    fprintf(fileID,format_list,new_names{i},new_scores(i));
end
fclose(fileID);