%% input 
% movingImageFile: moving image file name
% image2Name: fixed (traget) image file name
% movingImageTransforFunction: target image
% example input files
% movingImageFile: 'input\registration_images\imageScope.PNG'
% fixedImageFile: 'input\registration_images\Qupath.PNG'
% movingImageTransforFunctionFile: 'input\registration_images\movingReg.mat'


%% output
% fixedOutput: registerred fixed image
% movingOutput: registerred moving image


%% description
% 1. use Registration Estimator to calculate movingImageTransforFunction
%     a. load correct moving and fix images
%     b. do registration
%     c. click export to workspace and save the movingImageTransforFunction
%     in "movingReg"
%     d. save movingImageTransforFunction to
%     movingImageTransforFunctionFile
% 2. Run ImageRegistration
function [movingOutput,fixedOutput] = ImageRegistration(movingImageFile,fixedImageFile,movingImageTransforFunctionFile)

    movingImage = imread(movingImageFile);
    fixedImage = imread(fixedImageFile);
    movingReg = load(movingImageTransforFunctionFile);
    transformation = movingReg.movingReg.Transformation;
    transformationMatrix = transformation.T;

    temp = [1,1,1]*transformationMatrix;
    imageTopLeft = temp(1:2);
    [m_move,n_move,color] = size(movingImage);
    temp1 = [n_move,m_move,1]*transformationMatrix;
    imageBottomRight = temp1;
    %imageBottomRight = [m_move-1+temp(2),n_move-1+temp(1)];
    
    [m_fix,n_fix,color] = size(fixedImage);
    
    fixed = rgb2gray(fixedImage);
    moving = rgb2gray(movingImage);
    fixedRefObj = imref2d(size(fixed));
    movingRefObj = imref2d(size(moving));
    movedImage(:,:,1) = imwarp(movingImage(:,:,1), movingRefObj, transformation, 'OutputView', fixedRefObj, 'SmoothEdges', true);
    movedImage(:,:,2) = imwarp(movingImage(:,:,2), movingRefObj, transformation, 'OutputView', fixedRefObj, 'SmoothEdges', true);
    movedImage(:,:,3) = imwarp(movingImage(:,:,3), movingRefObj, transformation, 'OutputView', fixedRefObj, 'SmoothEdges', true);

    usedCol1 = max(round(imageTopLeft(1)),1);
    usedRow1 = max(round(imageTopLeft(2)),1);
    
    usedCol2 = min(round(imageBottomRight(1)),n_fix);
    usedRow2 = min(round(imageBottomRight(2)),m_fix);

    fixedOutput = fixedImage(usedRow1:usedRow2,usedCol1:usedCol2,:);
    movingOutput = movedImage(usedRow1:usedRow2,usedCol1:usedCol2,:);
end

