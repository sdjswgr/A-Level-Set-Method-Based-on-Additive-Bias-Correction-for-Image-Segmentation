function [sigma,alfa,iterNum,k,initialLSF] = ABC_Switch(imgID,c0,initialLSF)

% Hard-coded settings for processing each image. 


 %% **********************************************************************
% All rights researved by Guirong Weng, who formulated the model, designed
% and implemented the algorithm in the above paper.
% E-mail:wgr@suda.edu.cn, 2020.2.12
% A Level Set Method Based on Additive Bias Correction for Image Segmentation
% ESWA_115633,2021
% Expert Systems With Applications
%% ***********************************************************************
switch imgID
      
    case 1
           sigma=4;alfa=3;k=7;iterNum=7;
           initialLSF(27:61,12:90) = -c0; 
    case 2
           sigma=4;alfa=3;k=7;iterNum=30;
           initialLSF(22:55,23:65) = -c0;
    case 3
           sigma=4;alfa=3;k=7;iterNum=25;
           initialLSF(41:65,45:89) = -c0; 
    case 4     
          sigma=4;alfa=3;k=7;iterNum=55;
          initialLSF(60:75,50:63) = -c0 ;
    case 5
           sigma=4;alfa=3;k=7;iterNum=95;
           initialLSF(30:56,87:96) = -c0;
    case 6
           sigma=4;alfa=3;k=7;iterNum=8;
           initialLSF(20:60,20:65)=-c0;  
    case 7
           sigma=4;alfa=3;k=7;iterNum=15;
           initialLSF(60:100,40:80) = -c0;
    case 8 
           sigma=4;alfa=3;k=7;iterNum=45;
           initialLSF(50:82,36:62) = -c0;
    case 9
           sigma=4;alfa=3;k=7;iterNum=40;
           initialLSF(15:60,15:65)=-c0;
    case 10
           sigma=4;alfa=3;k=7;iterNum=25;
           initialLSF(40:65,40:90) = -c0; 
    case 11
           sigma=4;alfa=3;k=7;iterNum=20;
           initialLSF(23:60,23:65)=-c0;
    case 12
           sigma=4;alfa=3;k=7;iterNum=30;
           initialLSF(23:60,20:75)=-c0;
    case 13
           sigma=4;alfa=3;k=7;iterNum=20;
           initialLSF(50:85,45:85) = -c0;
    case 14 
           sigma=4;alfa=3;k=7;iterNum=10;
           initialLSF(15:80,25:90) = -c0;
           initialLSF(130:190,185:250) = -c0;
    case 15        
           sigma=4;alfa=3;k=7;iterNum=150;
           initialLSF(120:170,100:335) = -c0;

end

