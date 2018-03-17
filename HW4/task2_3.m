function [] = task2_3( )

input_img=imread('./image/task_2.png');
input_img=noise_maker(input_img,1,0,0.2);

filter3 = [1,1,1;1,1,1;1,1,1];
a = filter2d(input_img,filter3,-1); %调和
b1 = filter2d(input_img,filter3,1.5); %谐波 Q=1.5
b2 = filter2d(input_img,filter3,-1.5); %谐波 Q=-1.5

subplot(2,2,1);
imshow(input_img);   %原图
title('添加盐噪声后');

subplot(2,2,2);
imshow(a);  %滤波化后的图
title('3x3调和均值滤波');

subplot(2,2,3);
imshow(b1);  %滤波化后的图
title('3x3反调和均值滤波 Q=1.5');

subplot(2,2,4);
imshow(b2);  %滤波化后的图
title('3x3反调和均值滤波 Q=-1.5');
end

