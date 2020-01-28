%% input 
% image1Name: ROI for viewer 1
% image2Name: ROI for viewer 2
% threshold: threshold for pixel difference

%% output
% averageDiff: 3 channles average difference
% maxDiff: 3 channles max difference
% percentageOverThreshold: 3 channles percentage of pixel, which difference
% is larger than threshold.
function [ averageDiff, maxDiff, percentageOverThreshold ] = compareColorFunction(image1Name, image2Name,threshold)

    image1=imread(image1Name);
    image2 = imread(image2Name);


    image1 = double(image1);
    image2 = double(image2);
    [row,col,channel] = size(image2);

    % compare channel by channel, calculate 
    % 1. mean of absolute difference
    % 2. max difference
    % 3. var of difference
    % 4. number and percenatge of pixel over threshold
    DifR = image1(:,:,1)-image2(:,:,1);
    AveDiffR  = mean(abs(DifR(:)));
    VarDiffR = var(DifR(:));
    MaxDiffR = max(abs(DifR(:)));
    VectorR=DifR(:);
    OutR= sum(abs(VectorR)>threshold);
    PerR = OutR/row/col;
    figure
    imagesc(abs(DifR));
    colorbar;


    DifG = image1(:,:,2)-image2(:,:,2);
    AveDiffG  = mean(abs(DifG(:)));
    VarDiffG = var(DifG(:));
    MaxDiffG = max(abs(DifG(:)));
    VectorG= DifG(:);
    OutG = sum(abs(VectorG)>threshold);
    PerG = OutG/row/col;
    figure
    imagesc(abs(DifG));
    colorbar;


    DifB= image1(:,:,3)-image2(:,:,3);
    AveDiffB  = mean(abs(DifB(:)));
    VarDiffB = var(DifB(:));
    MaxDiffB = max(abs(DifB(:)));
    VectorB= DifB(:);
    OutB = sum(abs(VectorB)>threshold);
    PerB = OutB/row/col;
    figure
    imagesc(abs(DifB));
    colorbar;
    
    averageDiff = [AveDiffR,AveDiffG,AveDiffB];
    maxDiff = [MaxDiffR,MaxDiffG,MaxDiffB];
    percentageOverThreshold = [PerR,PerR,PerR];
end

