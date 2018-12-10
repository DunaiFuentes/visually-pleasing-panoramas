% We want to use the same Train.txt and Test.txt files (same images and labels) but
% repeating the experiment with hand-extracted features instead of applying
% convolutional networks to a patch of the image.

% Alternatively to running this script (which is a bit tricky because it hasn't been fully automated,
% you may use 'MDS.m' that loads the already computed features.

% First move Train.txt and Test.txt to working directory
fileID = fopen('Train.txt','r'); %Manually change the name and save with the appropiate name of the files for train and test
formatSpec = '%s %d';
A = textscan(fileID,formatSpec);
fclose(fileID);

labels = A{2};
images = A{1};

for i = 1:length(images)
    I = imread(images{i,:}); %We open an image for processing
    
    E = entropy(I); %Entropy (greyscale) is one of the features we want to consider as it captures the complexity
    
    try %because some images come in greyscale
        hsv_image = rgb2hsv(I);
        Hue = hsv_image(:,:,1);
        Saturation = hsv_image(:,:,2);
        Brightness = hsv_image(:,:,3);
        
        %Other features we are interested in are mean brightness, mean
        %saturation and Hues peaks.
        S = mean2(Saturation);
        B = mean2(Brightness);
        [counts,binLocations] = imhist(Hue);
        % Take 5 maximums
        [values,idx] = sort(counts);
        HuePeaks = binLocations(idx(end-4:end));
    catch
        HuePeaks = zeros(5,1);
        S = 0;
        B = mean2(I);
    end
    
    % Build the feature vector
    features(i,:) = [E S B HuePeaks'];
end

%normalize 
features_train = zscore(features); %Manually change the name and save with the appropiate name of the files for train and test