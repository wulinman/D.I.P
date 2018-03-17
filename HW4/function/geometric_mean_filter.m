function [ output_img ] = geometric_mean_filter( input_img, filter)
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
        product=1;
        for a=-ss:ss
            for b=-tt:tt
                %是否越界，越界的则当成0
                 if (i+a>=1 && i+a<=m && j+b>=1 && j+b<=n)
                         product = product * (f(i+a,j+b)*filter(ss+1+a,tt+1+b));
                 end
            end
        end
            output_img(i,j)=product^(1/(s*t));
    end
end

output_img=uint8(output_img);
end

