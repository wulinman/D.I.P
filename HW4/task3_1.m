function [ ] = task3_1( )
%main function for question 2.4.1
input_img=imread('./image/14.png');
R=input_img(:,:,1);
G=input_img(:,:,2);
B=input_img(:,:,3);

result_R=equalize_hist(R);
result_G=equalize_hist(G);
result_B=equalize_hist(B);

%�ع�RGBͼ
output_img=cat(3,result_R,result_G,result_B);
output_img=uint8(output_img);

%figure,imshow(output_img);
subplot(1,2,1);
imshow(input_img);   %ԭͼ
title('Origin Image');

subplot(1,2,2);
imshow(output_img);   %���⻯����ͨ���ϳ�
title('Result Image');

%figure,imshow(output_img);

end

