To run it is important that the content of this folder, the Classify.txt file 'from Panoramas2Classify_LowRes', and the Train_b.txt and Test_b.txt files from 'FlickrPanoramaCrawler' are all in the working directory.

	Script 'MakingSense_ofOutput.m' can be used to visualize the generated raking after computing your own predictions or to visualize our own by importing 'VPP_Data_RR\Approach 2\Log_&_Output\output_FPanorama.txt.prediction' to the working directory.

	Instead of visualizing you may also compute the matching to human made raking with 'New_MakingSense_ofOutput.m'. This script constructs a ranking from the predictions and computes the Top3 + Bottom3 correct classification. Additionally it also computes the random case performance and shows the boxplot of Figure 10. 