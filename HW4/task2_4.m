function [ ] = task2_4()
%UNTITLED4 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
input_img=imread('./image/task_2.png');
input_img=noise_maker(input_img,1,0.2,0.2);
filter3 = [1,1,1;1,1,1;1,1,1];
filter5 = [1,1,1,1,1,1,1,1,1;
            1,1,1,1,1,1,1,1,1;
            1,1,1,1,1,1,1,1,1;
            1,1,1,1,1,1,1,1,1;
            1,1,1,1,1,1,1,1,1];
a = filter2d(input_img,filter5,0); %����
b = geometric_mean_filter(input_img, filter3); %����
c = max_filter(input_img, filter3); %���ֵ
d = min_filter(input_img, filter3); %��Сֵ
e = median_filter(input_img, filter5); %��ֵ

subplot(2,3,1);
imshow(input_img);   %����ͼ��
title('����˽���������');

subplot(2,3,2);
imshow(a);  %�˲����ͼ
title('5x5������ֵ�˲�');

subplot(2,3,3);
imshow(b);  %�˲����ͼ
title('3x3���ξ�ֵ�˲�');

subplot(2,3,4);
imshow(c);  %�˲������ͼ
title('3x3���ֵ�˲�');

subplot(2,3,5);
imshow(d);  %�˲������ͼ
title('3x3��Сֵ�˲�');

subplot(2,3,6);
imshow(e);  %�˲������ͼ
title('5x5��ֵ�˲�');

end

