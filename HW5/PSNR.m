function [ output ] = PSNR( img1,img2 )
%This function returns the PSNR value of input_img1 and input_img2
img1=double(img1);
img2=double(img2);

%RGB to YCbCr
[m1,n1,v1]=size(img1);
if(v1>1)
    img1=rgb2ycbcr(img1);
    img1=img1(:,:,1);
end
[m2,n2,v2]=size(img2);
if(v2>1)
    img2=rgb2ycbcr(img2);
    img2=img2(:,:,1);
end

%compute
imdff=img1-img2;
imdff=imdff(:); %将二维的imdff矩阵转为一维
mse=mean(imdff.^2); %求均值，相当于/mn
psnr=20*log10(255/sqrt(mse));

output=psnr;
end

