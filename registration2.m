clc
clear all
close all
movingImage = imread('input\registration_images\imageScope.PNG');
fixedImage = imread('input\registration_images\Qupath.PNG');
movingReg = load('movingReg');
transformation = movingReg.movingReg.Transformation;
transformationMatrix = transformation.T;
% transform image 2
[image2Row,image2Col,c]= size(fixedImage);
temp = [1,1,1]*transformationMatrix;
image2TopLeft = temp(1:2);


fixed = rgb2gray(fixedImage);
moving = rgb2gray(movingImage);
fixedRefObj = imref2d(size(fixed));
movingRefObj = imref2d(size(moving));
movedImage(:,:,1) = imwarp(movingImage(:,:,1), movingRefObj, transformation, 'OutputView', fixedRefObj, 'SmoothEdges', true);
movedImage(:,:,2) = imwarp(movingImage(:,:,2), movingRefObj, transformation, 'OutputView', fixedRefObj, 'SmoothEdges', true);
movedImage(:,:,3) = imwarp(movingImage(:,:,3), movingRefObj, transformation, 'OutputView', fixedRefObj, 'SmoothEdges', true);

usedCol = max(round(image2TopLeft(1)),1);
usedRow = max(round(image2TopLeft(2)),1);

fixedOutput = fixedImage(usedRow:end,usedCol:end,:);
movingOutput = movedImage(usedRow:end,usedCol:end,:);
figure
imshow(fixedOutput);
figure
imshow(movingOutput);


% [m1,n1,c]= size(image1);
% [m2,n2,c]= size(image2);
% m=min(m1,m2);
% n=min(n1,n2);
% image1 = image1(1:m,1:n,:);
% image2 = image2(1:m,1:n,:);
% [optimizer, metric] = imregconfig('multimodal');
% imregister(rgb2gray(image1), rgb2gray(image2), 'affine', optimizer, metric);
% movingRegistered1 = imregister(image1(:,:,1), image2(:,:,1), 'affine', optimizer, metric);
% movingRegistered2 = imregister(image1(:,:,2), image2(:,:,2), 'affine', optimizer, metric);
% movingRegistered3 = imregister(image1(:,:,3), image2(:,:,3), 'affine', optimizer, metric);
% registeredImage2(:,:,1) =movingRegistered1;
% registeredImage2(:,:,2) =movingRegistered2;
% registeredImage2(:,:,3) =movingRegistered3;
% 
% image2New(:,:,1) = imwarp(image2(:,:,1),transforFunction.transforFunction);
% image2New(:,:,2) = imwarp(image2(:,:,2),transforFunction.transforFunction);
% image2New(:,:,3) = imwarp(image2(:,:,3),transforFunction.transforFunction);
% imshowpair(image1, image2New,'Scaling','joint');