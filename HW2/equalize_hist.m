function [ output_img ] = equalize_hist( input_img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

f=imread(input_img);
[m,n]=size(f); %m-height, n-width

count=zeros(1,256);
for i=1:m
    for j=1:n
        count(f(i,j)+1)= count(f(i,j)+1)+1; %灰度为f(i,j)的像素个数
    end
end

%计算不同灰度值像素个数的累计个数，即cdf的分子
sum=zeros(1,256);
for i=1:256
    for j=1:i
        sum(i)=sum(i)+count(j);
    end
end

out_count=zeros(1,256);
for i=1:m
    for j=1:n
        output_img(i,j)= round(sum(f(i,j)+1)*255 /(m*n));
        out_count(output_img(i,j)+1)= out_count(output_img(i,j)+1)+1; %灰度为output_img(i,j)的像素个数
    end
end

%将直方图纵坐标转化为normalized直方图的纵坐标
% p=n/MN
origin_p=zeros(1,256);
output_p=zeros(1,256);
for i=1:256
    origin_p(i)=count(i)/(m*n);  
    output_p(i)=out_count(i)/(m*n);
end

output_img=uint8(output_img);

subplot(2,2,1);
imshow(f);   %原图
title('Origin Image');

subplot(2,2,2);
imshow(output_img);  %均衡化后的图
title('Equalizing Image');

subplot(2,2,3);
bar(1:256,origin_p); %原图的直方图
title('Origin Histogram');

subplot(2,2,4);
bar(1:256,output_p); %均衡化后的直方图
title('Equalizing Histogram');

end

