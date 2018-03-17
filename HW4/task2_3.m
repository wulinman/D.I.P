function [] = task2_3( )

input_img=imread('./image/task_2.png');
input_img=noise_maker(input_img,1,0,0.2);

filter3 = [1,1,1;1,1,1;1,1,1];
a = filter2d(input_img,filter3,-1); %����
b1 = filter2d(input_img,filter3,1.5); %г�� Q=1.5
b2 = filter2d(input_img,filter3,-1.5); %г�� Q=-1.5

subplot(2,2,1);
imshow(input_img);   %ԭͼ
title('�����������');

subplot(2,2,2);
imshow(a);  %�˲������ͼ
title('3x3���;�ֵ�˲�');

subplot(2,2,3);
imshow(b1);  %�˲������ͼ
title('3x3�����;�ֵ�˲� Q=1.5');

subplot(2,2,4);
imshow(b2);  %�˲������ͼ
title('3x3�����;�ֵ�˲� Q=-1.5');
end

