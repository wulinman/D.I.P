function [ output_img ] = min_filter(input_img, filter)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n,z]=size(input_img); %m-height, n-width, z=dimension
if (z>1)
    input_img=rgb2gray(input_img);
end
f=double(input_img);

[s,t]=size(filter);
ss=(s-1)/2; %（高-1）/2
tt=(t-1)/2; %（宽-1）/2

output_img = zeros(m,n);
for i=1:m
    for j=1:n
        temp=zeros(s,t);
        for a=-ss:ss
            for b=-tt:tt
                %是否越界，越界的则当成0
                 if (i+a>=1 && i+a<=m && j+b>=1 && j+b<=n)
                         temp(ss+1+a,tt+1+b)=f(i+a,j+b);
                 end
            end
        end
            output_img(i,j)=min(temp(:));
    end
end

output_img=uint8(output_img);
subplot(1,2,1);
imshow(input_img);   %原图
title('Origin Image');

subplot(1,2,2);
imshow(output_img);  %滤波化后的图
title('Result Image');

end