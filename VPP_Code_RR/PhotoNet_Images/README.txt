

'Reading_PhotoNet_Script.m' both downloads the images from Photo.net dataset and prepares the data for CNTK (Train.txt and Test.txt). It uses as reference '0_photonet_dataset.txt' that has been uploaded in 'VPP_Data_RR/PhotoNet_Images'.


'Figure1_Feature_Extractor.m' is used to compute the handcrafted features for Photo.net images
(Requires Train.txt and Test.txt). Its usage can be skipped as they have already been provided in 'VPP_Data_RR/PhotoNet_Images'.
	
'MDS.m' and 'Train2_Test2_Generator.m' use those computed features to print Figure1 and prepares the data for CNTK respectively (creating Train2.txt and Test2.txt).