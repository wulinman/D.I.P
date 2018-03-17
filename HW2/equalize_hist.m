function [ output_img ] = equalize_hist( input_img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

f=imread(input_img);
[m,n]=size(f); %m-height, n-width

count=zeros(1,256);
for i=1:m
    for j=1:n
        count(f(i,j)+1)= count(f(i,j)+1)+1; %�Ҷ�Ϊf(i,j)�����ظ���
    end
end

%���㲻ͬ�Ҷ�ֵ���ظ������ۼƸ�������cdf�ķ���
sum=zeros(1,256);
for i=1:256
    for j=1:i
        sum(i)=sum(i)+count(j);
    end
end

out_count=zeros(1,256);
for i=1:m
    for j=1:n
        output_img(i,j)= round(sum(f(i,j)+1)*255 /(m*n));
        out_count(output_img(i,j)+1)= out_count(output_img(i,j)+1)+1; %�Ҷ�Ϊoutput_img(i,j)�����ظ���
    end
end

%��ֱ��ͼ������ת��Ϊnormalizedֱ��ͼ��������
% p=n/MN
origin_p=zeros(1,256);
output_p=zeros(1,256);
for i=1:256
    origin_p(i)=count(i)/(m*n);  
    output_p(i)=out_count(i)/(m*n);
end

output_img=uint8(output_img);

subplot(2,2,1);
imshow(f);   %ԭͼ
title('Origin Image');

subplot(2,2,2);
imshow(output_img);  %���⻯���ͼ
title('Equalizing Image');

subplot(2,2,3);
bar(1:256,origin_p); %ԭͼ��ֱ��ͼ
title('Origin Histogram');

subplot(2,2,4);
bar(1:256,output_p); %���⻯���ֱ��ͼ
title('Equalizing Histogram');

end

