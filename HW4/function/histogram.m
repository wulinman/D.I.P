function [output_hist] = histogram( input_img )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
f=input_img;
[m,n]=size(f); %m-height, n-width

count=zeros(1,256);
for i=1:m
    for j=1:n
        count(f(i,j)+1)= count(f(i,j)+1)+1; %�Ҷ�Ϊf(i,j)�����ظ���
    end
end

output_hist=count;
end

