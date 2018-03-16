function [ output_img ] = quantize( input_img,level )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

f=imread(input_img);
[m,n]=size(f); %m-height, n-width

p=255/(level-1); 
L=256/level; %length of block

for i=1:m
    for j=1:n
        output_img(i,j)=floor(f(i,j)/L)*p;
    end
end

output_img=uint8(output_img);
imshow(f);
figure,imshow(output_img);
end

