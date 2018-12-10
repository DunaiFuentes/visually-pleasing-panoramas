
% This script downloads the images for the specified "time" intervals from http://panorama.epfl.ch/ 

my_path = 'C:/Users/Dunai/Desktop/VPP_Data_RR/Panoramas2Classify_Crawler/'; %Change for your own

store_format = strcat(my_path,'Raw/%d_%02d_%02d_%02d_%02d.jpg');
url_format = 'http://panorama.epfl.ch/data/foto_db/%d/%02d/%02d/%d_%02d%02d_%02d%02d00.jpg';

year = [2016];
month =[1:3];
day = [1:31];
hour = [6:20];
minute = [00:10:50];

for y=1:length(year)
    for mo=1:length(month)
        for d=1:length(day)
            for h=1:length(hour)
                for min=1:length(minute)
                    filename = sprintf(store_format, year(y), month(mo), day(d), hour(h), minute(min));
                    url = sprintf(url_format, year(y), month(mo), day(d), year(y), month(mo), day(d), hour(h), minute(min));
                    try
                        websave(filename,url);
                    catch
                        warning('prob here')
                    end
                end
            end
        end
    end
end