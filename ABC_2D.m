function [u,r,b1,b2] = ABC_2D(Img,u,Ksigma,KONE,r,beta,alfa,epsilon,timestep)
     % Level Set Method Based on Additive Bias Correction for Image Segmentation
     %
     % function [u,r,b1,b2] = ABC_2D(Img,u,Ksigma,KONE,r,beta,alfa,epsilon,timestep)
     %
     % Inputs
     %
     % Outputs
     %
     % Author
     % Guirong Weng
     % School of Mechanical and Electric Engineering
     % Soochow University
     % Suzhou 215021
     % China


     Hu = 0.5*(1+(2/pi)*atan(u./epsilon));
     % ----Calculation method of bias field fitting b1, b2
     Nb1 = conv2((Img-r).*Hu,Ksigma,'same');      
     Dk1 = conv2(Hu,Ksigma,'same');
     b1 = Nb1./Dk1;                                          %  in Eq.(19)
     Nb2 = conv2((Img-r).*(1-Hu),Ksigma,'same');
     Dk2 = KONE-Dk1;   % Optimization calculation method
     b2 = Nb2./Dk2;                                         %   in Eq.(19)


     % --- r Calculation method of reflection image£º -----------------
     PC1 = (Img-b1).*Hu+(Img-b2).*(1-Hu);
     KNr1 = conv2(PC1,Ksigma,'same');
     KDr1 = KONE;
     r = KNr1./KDr1;                                        %   in Eq.(20)


     %---- Calculation method of drivers  ------------------------------------ 
     s1 = b1.^2-b2.^2;
     s2 = b1-b2;
     e = conv2(s1,Ksigma,'same')-2.*(Img-r).*conv2(s2,Ksigma,'same');%in Eq.(21)
     dataForce = -alfa*tanh(e./beta);                          %  in Eq.(24)      
     Dirac = (epsilon/pi)./(epsilon^2.+u.^2);
     u = u+timestep*Dirac.*dataForce;
%-------------------------------------------------------------------------------------------   
end




%% **********************************************************************
% A Level Set Method Based on Additive Bias Correction for Image Segmentation
% Author:Guirong Weng,(School of Mechanical and Electric Engineering, Soochow University, Suzhou 215021, China)
% All rights researved by Guirong Weng, who formulated the model, designed
% and implemented the algorithm in the above paper.
% E-mail:wgr@suda.edu.cn, 2020.2.12
% ESWA_115633,2021
% Expert Systems With Applications
%% ***********************************************************************
