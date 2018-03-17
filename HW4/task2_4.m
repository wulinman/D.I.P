function [ ] = task2_4()
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
input_img=imread('./image/task_2.png');
input_img=noise_maker(input_img,1,0.2,0.2);
filter3 = [1,1,1;1,1,1;1,1,1];
filter5 = [1,1,1,1,1,1,1,1,1;
            1,1,1,1,1,1,1,1,1;
            1,1,1,1,1,1,1,1,1;
            1,1,1,1,1,1,1,1,1;
            1,1,1,1,1,1,1,1,1];
a = filter2d(input_img,filter5,0); %算术
b = geometric_mean_filter(input_img, filter3); %几何
c = max_filter(input_img, filter3); %最大值
d = min_filter(input_img, filter3); %最小值
e = median_filter(input_img, filter5); %中值

subplot(2,3,1);
imshow(input_img);   %输入图像
title('添加了椒盐噪声后');

subplot(2,3,2);
imshow(a);  %滤波后的图
title('5x5算术均值滤波');

subplot(2,3,3);
imshow(b);  %滤波后的图
title('3x3几何均值滤波');

subplot(2,3,4);
imshow(c);  %滤波化后的图
title('3x3最大值滤波');

subplot(2,3,5);
imshow(d);  %滤波化后的图
title('3x3最小值滤波');

subplot(2,3,6);
imshow(e);  %滤波化后的图
title('5x5中值滤波');

end

