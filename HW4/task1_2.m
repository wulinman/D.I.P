function [] = task1_2( )

input_img=imread('./image/task_1.png');
filter3 = [1,1,1;1,1,1;1,1,1];
filter9 = [1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1;
           1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1;
           1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1;];
       
%Q=-1Ϊ���;�ֵ�˲���
output_img1=filter2d(input_img,filter3,-1);
output_img2=filter2d(input_img,filter9,-1);

subplot(2,2,1);
imshow(input_img);   %ԭͼ
title('ԭͼ');

subplot(2,2,3);
imshow(output_img1);
title('3x3���;�ֵ�˲���Ч��ͼ');

subplot(2,2,4);
imshow(output_img2);
title('9x9���;�ֵ�˲���Ч��ͼ');

end

