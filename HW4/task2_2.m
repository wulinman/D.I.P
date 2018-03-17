function [ ] = task2_2()
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
input_img=imread('./image/task_2.png');
input_img=noise_maker(input_img,0,0,40);
filter3 = [1,1,1;1,1,1;1,1,1];
a = filter2d(input_img,filter3,0); %算术
b = geometric_mean_filter(input_img, filter3); %几何
c = median_filter(input_img, filter3); %中值

subplot(2,2,1);
imshow(input_img);   %原图
title('添加高斯噪声');

subplot(2,2,2);
imshow(a);  %滤波化后的图
title('3x3算术均值滤波');

subplot(2,2,3);
imshow(b);  %滤波化后的图
title('3x3几何均值滤波');

subplot(2,2,4);
imshow(c);  %滤波化后的图
title('3x3中值均值滤波');

end

