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
        histR(R(i,j)+1)= histR(R(i,j)+1)+1; %�Ҷ�Ϊf(i,j)�����ظ���
    end
end
histG=zeros(1,256);
for i=1:m
    for j=1:n
        histG(G(i,j)+1)= histG(G(i,j)+1)+1; %�Ҷ�Ϊf(i,j)�����ظ���
    end
end
histB=zeros(1,256);
for i=1:m
    for j=1:n
        histB(B(i,j)+1)= histB(B(i,j)+1)+1; %�Ҷ�Ϊf(i,j)�����ظ���
    end
end

hist=zeros(1,256);
for i = 1:256
    hist(i)=mean([histR(i),histG(i),histB(i)]);
end

%�Ծ�ֱֵ��ͼhist�����⻯

%�����ۼƸ���
sum=zeros(1,256);
for i=1:256
    for j=1:i
        sum(i)=sum(i)+hist(j);
    end
end

%��ƽ��ֱ��ͼ���о��⻯��ӳ�䵽RGBͨ��
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

%�ع�RGBͼ
output_img=cat(3,equalize_R,equalize_G,equalize_B);
output_img=uint8(output_img);

subplot(1,2,1);
imshow(input_img);   %ԭͼ
title('Origin Image');

subplot(1,2,2);
imshow(output_img);   %���⻯���ͼ��
title('Result Image');
%figure,imshow(output_img);

end

