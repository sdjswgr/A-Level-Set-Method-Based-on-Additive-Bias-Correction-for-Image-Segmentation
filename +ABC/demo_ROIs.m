function initialLSF = demo_ROIs(Img1,imgID)
% Hard-coded box settings for processing each image. 
%
% function initialLSF = demo_ROIs(Img1,imgID)
%
% Purpose
% Return initial contour for the demo image based on hard-coded settings.
%
% Inputs
% Img1 - the image matrix we want to get a mask from
% imgID - the ID of the image file name

c0 = 1;
initialLSF = ones(size(Img1(:,:,1))).*c0; %This is a mask (initial contour) from which we grow. 

switch imgID

    case 1
           initialLSF(27:61,12:90) = -c0;
    case 2
           initialLSF(22:55,23:65) = -c0;
    case 3
           initialLSF(41:65,45:89) = -c0;
    case 4     
          initialLSF(60:75,50:63) = -c0 ;
    case 5
           initialLSF(30:56,87:96) = -c0;
    case 6
           initialLSF(20:60,20:65)=-c0;
    case 7
           initialLSF(60:100,40:80) = -c0;
    case 8 
           initialLSF(50:82,36:62) = -c0;
    case 9
           initialLSF(15:60,15:65)=-c0;
    case 10
           initialLSF(40:65,40:90) = -c0;
    case 11
           initialLSF(23:60,23:65)=-c0;
    case 12
           initialLSF(23:60,20:75)=-c0;
    case 13
           initialLSF(50:85,45:85) = -c0;
    case 14 
           initialLSF(15:80,25:90) = -c0;
           initialLSF(130:190,185:250) = -c0;
    case 15
           initialLSF(120:170,100:335) = -c0;
end


 %% **********************************************************************
% All rights researved by Guirong Weng, who formulated the model, designed
% and implemented the algorithm in the above paper.
% E-mail:wgr@suda.edu.cn, 2020.2.12
% A Level Set Method Based on Additive Bias Correction for Image Segmentation
% ESWA_115633,2021
% Expert Systems With Applications
%% ***********************************************************************
