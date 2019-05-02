%% input 
% image1Name: ROI for viewer 1
% image2Name: ROI for viewer 2


%% output
% difMatix: Euclidean distance in the CIELAB space 
function [ difMatix ] = compareColorFunction_LAB( image1Name, image2Name)

    image1 = imread(image1Name);
    image2 = imread(image2Name);   
    
    % cover image in to CIELAB
    CIELAB1 = rgb2lab(image1);
    CIELAB2 = rgb2lab(image2);    
    
    % compare euclidean distance in CIELAB space
    % use matix
    %difMatix = sqrt((CIELAB1(:,:,1)- CIELAB2(:,:,1)).^2 + (CIELAB1(:,:,2)- CIELAB2(:,:,2)).^2 + (CIELAB1(:,:,3)- CIELAB2(:,:,3)).^2);
    
    % use vector
    [row,col,channel] = size(CIELAB1);
    CIELAB1vector = reshape(CIELAB1,row*col,[]);
    CIELAB2vector = reshape(CIELAB2,row*col,[]);
    
    dif2D = (CIELAB1vector - CIELAB2vector).^2;
    dif1D = sqrt(sum(dif2D,2));
    difMatix = reshape(dif1D,row,col);
    save('dE.mat','difMatix');
    imagesc(difMatix);
    colorbar;
end

