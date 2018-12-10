my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/Panoramas2Classify_Crawler/'; %Change for your own

%RUN THE APPROPIATE SECTION!
%% From the beginning
rng(42)
list = dir(strcat(my_path,'Raw/'));
idx = randperm(length(list));
list = list(idx);

for i = 1:length(list) %We are gonna show the images to vote.
    figure
    imshow(sprintf(strcat(my_path,'Raw/%s',list(i).name)))
    pause(2) % Only 2 seconds per image! If you wanna take it slowly just change this
    close
    prompt = 'Rank this image with intergers from 0 to 9, being 0 the lowest score and 9 the highest:\n';
    list(i).score = input(prompt);
end % If you do not want to label ALL the images, stop and save your progress with the following lines ...

%These had to be run manually
next_start_idx = i;
save(strcat(my_path,'next_start_idx.mat'),'next_start_idx');
save(strcat(my_path,'list_with_scores.mat'),'list');

%% ... And then continue from another list
load('list_with_scores');
load('next_start_idx');

for i = next_start_idx:1200 %length(list)
    figure
    imshow(sprintf(strcat(my_path,'Raw/%s'),list(i).name))
    pause(2)
    close
    prompt = 'Rank this image with intergers from 0 to 9, being 0 the lowest score and 9 the highest:\n';
    list(i).score = input(prompt);
end 

%These had to be run manually
next_start_idx = i;
save(strcat(my_path,'next_start_idx.mat'),'next_start_idx');
save(strcat(my_path,'list_with_scores.mat'),'list');