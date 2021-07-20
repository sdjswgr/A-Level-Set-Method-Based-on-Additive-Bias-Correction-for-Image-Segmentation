%% A Level Set Method Based on Additive Bias Correction for Image Segmentation
% Author:Guirong Weng,(School of Mechanical and Electric Engineering, Soochow University, Suzhou 215021, China)
% All rights researved by Guirong Weng, who formulated the model, designed
% and implemented the algorithm in the above paper.
% E-mail:wgr@suda.edu.cn, 2020.2.12
% ESWA_115633,2021
% Expert Systems With Applications

%% Model theory:
% Image observed:i(x)=b(x)+r(x)+n(x);
% A: the illumination b is supposed to be varying smoothly, 
% B: the spatial derivatives of the observed intensity are mostly due to edges in the reflectance r.
% C: n is additive noise, The additive noise n can be assumed to be zero-mean Gaussian noise.
% D: r is therefore assumed to be piecewise (approximately)constant in a local region.

%%   
close all; clear; clc 
imgID = 15 ;   % image ID = 1 ~15
Img1 = imread([num2str(imgID),'.bmp']);  
c0 = 1; initialLSF = ones(size(Img1(:,:,1))).*c0;

% Three parameter settings, iteration, initial contour
[sigma,alfa,iterNum,k,initialLSF] = ABC_Switch(imgID,c0,initialLSF);

Img = double(Img1(:,:,1));
Img = log(1+Img/255);               % rescale the image intensities
fmin  = min(Img(:));
fmax  = max(Img(:));
Img = 255*(Img-fmin)/(fmax-fmin);  % Normalize Img to the range [0,255]
timestep = 1;                       % constant 1
epsilon = 1;                        % constant 1
G = fspecial('average',k);          % Create predefined filter
u = initialLSF;
r = zeros(size(Img));               % Initial the reflection image
Ksigma = fspecial('gaussian',round(2*sigma)*2+1,sigma); % Gaussian kernel
KONE = conv2(ones(size(Img)),Ksigma,'same');              % G*1, in Eq. (20)
beta = std2(Img);                   % Standard deviation of image in Eq.(25)

figure;imagesc(Img1); colormap(gray); axis off; axis equal
hold on; contour(initialLSF,[0 0],'g','LineWidth',2);
figure;imagesc(Img1); colormap(gray); axis off; axis equal

% -----start level set evolution-----
for  n = 1:iterNum
     [u,r,b1,b2] = ABC_2D(Img,u,Ksigma,KONE,r,beta,alfa,epsilon,timestep);
     u = tanh(7*u);                                %  constant 7,in Eq.(26)
     u = imfilter(u,G,'symmetric');                        %     in Eq.(27)
     
     if mod(n,10) == 0
        pause(0.01);
        imagesc(Img1); colormap(gray); axis off; axis equal;
        hold on; contour(u,[0 0],'g');title(n);
        hold off;
     end
     
end

hold on;contour(u,[0 0],'r','LineWidth',2);
iterNumN = [num2str(n), ' iterations']; title(iterNumN);
Hu = 0.5*(1+(2/pi)*atan(u./epsilon));
b = b1.*Hu+b2.*(1-Hu); % Bias field image
figure; imagesc(b); colormap(gray); axis off; axis equal;title('Bias image');
Ib = Img-b;          %  Bias correction image
figure; imagesc(Ib); colormap(gray); axis off; axis equal;title('Bias correction image');
figure; imagesc(r); colormap(gray); axis off; axis equal;title('ireflectance image');

