function [ ] = task1_1( )

input_img=imread('./image/task_1.png');
filter3 = [1,1,1;1,1,1;1,1,1];
filter9 = [1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1;
           1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1;
           1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1;];
       
%Q=0为算术均值滤波器
output_img1=filter2d(input_img,filter3,0);
output_img2=filter2d(input_img,filter9,0);

subplot(2,2,1);
imshow(input_img);   %原图
title('原图');

subplot(2,2,3);
imshow(output_img1);
title('3x3算术均值滤波器效果图');

subplot(2,2,4);
imshow(output_img2);
title('9x9算术均值滤波器效果图');

end

