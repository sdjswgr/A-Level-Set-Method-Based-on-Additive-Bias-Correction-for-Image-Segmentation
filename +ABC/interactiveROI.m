function initialLSF = interactiveROI(im)
% Return initial contour image based on a box drawn by the user
%
% function initialLSF = interactiveROI(im)



f=clf;

imagesc(im)

h = imrect(gca);

drawnBox = round(wait(h));



c0 = 1;
initialLSF = ones(size(im(:,:,1))).*c0; 

initialLSF(drawnBox(2):drawnBox(2)+drawnBox(4), ...
           drawnBox(1):drawnBox(1)+drawnBox(3)) = -c0;


delete(f)