function [ ] = task2_2()
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
input_img=imread('./image/task_2.png');
input_img=noise_maker(input_img,0,0,40);
filter3 = [1,1,1;1,1,1;1,1,1];
a = filter2d(input_img,filter3,0); %����
b = geometric_mean_filter(input_img, filter3); %����
c = median_filter(input_img, filter3); %��ֵ

subplot(2,2,1);
imshow(input_img);   %ԭͼ
title('��Ӹ�˹����');

subplot(2,2,2);
imshow(a);  %�˲������ͼ
title('3x3������ֵ�˲�');

subplot(2,2,3);
imshow(b);  %�˲������ͼ
title('3x3���ξ�ֵ�˲�');

subplot(2,2,4);
imshow(c);  %�˲������ͼ
title('3x3��ֵ��ֵ�˲�');

end

