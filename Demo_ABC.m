function Demo_ABC(imgID,drawBox)
   % Demo of a level set method based on additive bias correction for image segmentation
   %
   % function Demo_ABC(imgID,drawBox)
   %
   % Inputs
   % imgID - A scalar between 1 and 15 indicating which demo image to load. 15 images are provided. 
   %         If imgID is a matrix then we treat it as an image and invite use to draw a ROI. 
   % drawBox - optional. false by default. If true we interactively draw box rather than use
   %           the default values in ABC.demo_ROIs
   %
   % Author:
   % Guirong Weng,
   % School of Mechanical and Electric Engineering, Soochow University, Suzhou 215021, China


   %% Model theory:
   % Image observed:i(x)=b(x)+r(x)+n(x);
   % A: the illumination b is supposed to be varying smoothly, 
   % B: the spatial derivatives of the observed intensity are mostly due to edges in the reflectance r.
   % C: n is additive noise, The additive noise n can be assumed to be zero-mean Gaussian noise.
   % D: r is therefore assumed to be piecewise (approximately)constant in a local region.


   if nargin<1
      imgID = 15 ; % image ID = 1 ~15
   end

   if nargin<2
      drawBox=false;
   end


   % Get path to demo images and load
   if isscalar(imgID)
      tCodeDir = fileparts(which(mfilename));
      imgPath = fullfile(tCodeDir, 'demoImages', [num2str(imgID),'.bmp']);
      if exist(imgPath,'file')
         Img1 = imread(imgPath);
      else
         fprintf('Can not find demo image at %s\n', imgPath)
         return
      end
   elseif ismatrix(imgID)
      Img1 = imgID;
      drawBox = true;
   else
      fprintf('imgID must be a scalar or a matrix\n')
      return
   end


   % Get initial contour for the demo image based on hard-coded settings
   if drawBox
      initialLSF = ABC.interactiveROI(Img1);
   else
      initialLSF = ABC.demo_ROIs(Img1,imgID);
   end


   % Parameters
   tSD = 4;
   alfa=3;



   Img = double(Img1(:,:,1));
   Img = log(1+Img/255);               % rescale the image intensities
   fmin  = min(Img(:));
   fmax  = max(Img(:));
   Img = 255*(Img-fmin)/(fmax-fmin);  % Normalize Img to the range [0,255]
   timestep = 1;                       % constant 1
   epsilon = 1;                        % constant 1

   k=7;
   G = fspecial('average',k);          % Create predefined filter

   u = initialLSF;
   r = zeros(size(Img));               % Initial the reflection image
   Ksigma = fspecial('gaussian',round(2*tSD)*2+1,tSD); % Gaussian kernel
   KONE = conv2(ones(size(Img)),Ksigma,'same');              % G*1, in Eq. (20)
   beta = std2(Img);                   % Standard deviation of image in Eq.(25)


   clf
   subplot(2,3,1)
   imagesc(Img1)
   axis off equal


   hold on
   contour(initialLSF,[0 0],'g','LineWidth',2);


   subplot(2,3,2)
   h=imagesc(Img1);
   axis off equal


   % -----start level set evolution-----
   c=[]; % To be the handle the contour plot
   hold on

   lastU=ones(size(Img1));
   maxIter=500; %Max iterations
   bailoutDelta = 5E-5; % Used to decide when to break out of the loop
   for  n = 1:maxIter

         if n>1
            lastU = u;
         end

         [u,r,b1,b2] = ABC_2D(Img,u,Ksigma,KONE,r,beta,alfa,epsilon,timestep);

         u = tanh(7*u);                                %  constant 7,in Eq.(26)
         u = imfilter(u,G,'symmetric');                        %     in Eq.(27)
         d = lastU-u;

         % We break out if the difference between the images scaled by the number of pixels identified breaches thresh
         bailVal = sum(abs(d(:))) / sum(u(:));
         if bailVal < bailoutDelta 
            fprintf('Breaking at %d iterations\n',n)
            break
         end

         if mod(n,10) == 0
            delete(c)
            [~,c]=contour(u,[0 0],'g');
            title(n);
            drawnow
         end
   end

   delete(c)
   contour(u,[0 0],'r','LineWidth',2);

   iterNumN = [num2str(n), ' iterations']; 

   title(iterNumN);
   Hu = 0.5*(1+(2/pi)*atan(u./epsilon));
   b = b1.*Hu+b2.*(1-Hu); % Bias field image
   
   subplot(2,3,3)
   imagesc(b)
   colormap(gray)
   axis off equal
   title('Bias image');
   

   subplot(2,3,4)
   Ib = Img-b;          %  Bias correction image
   imagesc(Ib)
   colormap(gray)
   axis off equal
   title('Bias correction image');



   subplot(2,3,5)
   imagesc(r)
   colormap(gray)
   axis off equal
   title('Reflectance image');





   %% A Level Set Method Based on Additive Bias Correction for Image Segmentation
   % Author:Guirong Weng,(School of Mechanical and Electric Engineering, Soochow University, Suzhou 215021, China)
   % All rights researved by Guirong Weng, who formulated the model, designed
   % and implemented the algorithm in the above paper.
   % E-mail:wgr@suda.edu.cn, 2020.2.12
   % ESWA_115633,2021
   % Expert Systems With Applications