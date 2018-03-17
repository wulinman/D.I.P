function [ ] = task3_2( )
%main function for question 2.4.2
input_img=imread('./image/14.png');
R=input_img(:,:,1);
G=input_img(:,:,2);
B=input_img(:,:,3);
[m,n]=size(R); %m-height, n-width

histR=zeros(1,256);
for i=1:m
    for j=1:n
        histR(R(i,j)+1)= histR(R(i,j)+1)+1; %灰度为f(i,j)的像素个数
    end
end
histG=zeros(1,256);
for i=1:m
    for j=1:n
        histG(G(i,j)+1)= histG(G(i,j)+1)+1; %灰度为f(i,j)的像素个数
    end
end
histB=zeros(1,256);
for i=1:m
    for j=1:n
        histB(B(i,j)+1)= histB(B(i,j)+1)+1; %灰度为f(i,j)的像素个数
    end
end

hist=zeros(1,256);
for i = 1:256
    hist(i)=mean([histR(i),histG(i),histB(i)]);
end

%对均值直方图hist做均衡化

%计算累计个数
sum=zeros(1,256);
for i=1:256
    for j=1:i
        sum(i)=sum(i)+hist(j);
    end
end

%对平均直方图进行均衡化并映射到RGB通道
equalize_R=zeros(m,n);
equalize_G=zeros(m,n);
equalize_B=zeros(m,n);
for i=1:m
    for j=1:n
        equalize_R(i,j)= round(sum(R(i,j)+1)*255 /(m*n));
        equalize_G(i,j)= round(sum(G(i,j)+1)*255 /(m*n));
        equalize_B(i,j)= round(sum(B(i,j)+1)*255 /(m*n));
    end
end

%重构RGB图
output_img=cat(3,equalize_R,equalize_G,equalize_B);
output_img=uint8(output_img);

subplot(1,2,1);
imshow(input_img);   %原图
title('Origin Image');

subplot(1,2,2);
imshow(output_img);   %均衡化后的图像
title('Result Image');
%figure,imshow(output_img);

end

