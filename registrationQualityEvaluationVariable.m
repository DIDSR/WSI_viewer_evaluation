function registrationAccuracy = registrationQualityEvaluation(image1,image2)
%REGISTRATIONQUALITYEVALUATION Summary of this function goes here
%   Detailed explanation goes here
    CIELAB1 = rgb2lab(image1);
    CIELAB2 = rgb2lab(image2); 
    L1 = CIELAB1(:,:,1);
    L2 = CIELAB2(:,:,1);
    registrationAccuracy = corr2(L1,L2);
end

