clear all

my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/FlickrPanoramaCrawler/'; %Sustitude with your own path

fileID = fopen(strcat(my_path,'CrawlerOuputFile_b.txt'));
formatSpec = '%d %s %d';
C = textscan(fileID,formatSpec);
fclose(fileID);

url = C{2};
likes = C{3};

index0 = likes==0;
index1 = likes==10; %it's actually 10 or more

url0 = url(index0);
url1 = url(index1);

%we will take only  n_examples of each
n_examples = 200;
filename_format_0 = strcat(my_path,'Images_b/%d_0.jpg');
filename_format_1 = strcat(my_path,'Images_b/%d_1.jpg');
for i = 1:n_examples
    filename0 = sprintf(filename_format_0,i);
    filename1 = sprintf(filename_format_1,i);
    aux0 = url0{i};
    aux1 = url1{i};
    try
        outfilename0{i} = websave(filename0,aux0);
        outfilename1{i} = websave(filename1,aux1);
    catch
        warning('prob here')
    end
end

fileID = fopen('Train_b.txt','w');
format_list = '%s\t%d\r\n';
trainporportion = 0.8;
for i = 1:n_examples*trainporportion
    fprintf(fileID,format_list,outfilename0{i},0);
    fprintf(fileID,format_list,outfilename1{i},1);
end
fclose(fileID);

fileID = fopen('Test_b.txt','w');
format_list = '%s\t%d\r\n';
for i = n_examples*trainporportion+1:n_examples
    fprintf(fileID,format_list,outfilename0{i},0);
    fprintf(fileID,format_list,outfilename1{i},1);
end
fclose(fileID);