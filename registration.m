clc
clear all
close all
image1 = imread('input\registration_images\imageScope.PNG');
image2 = imread('input\registration_images\Qupath.PNG');
transforFunction = load('transformationFunction');
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

image2New(:,:,1) = imwarp(image2(:,:,1),transforFunction.transforFunction);
image2New(:,:,2) = imwarp(image2(:,:,2),transforFunction.transforFunction);
image2New(:,:,3) = imwarp(image2(:,:,3),transforFunction.transforFunction);
imshowpair(image1, image2New,'Scaling','joint');