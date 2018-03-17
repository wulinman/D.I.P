function [output_hist] = histogram( input_img )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
f=input_img;
[m,n]=size(f); %m-height, n-width

count=zeros(1,256);
for i=1:m
    for j=1:n
        count(f(i,j)+1)= count(f(i,j)+1)+1; %灰度为f(i,j)的像素个数
    end
end

output_hist=count;
end

