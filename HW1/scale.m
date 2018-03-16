function [ output_img ] = scale(input_img,width, height)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

f=imread(input_img);
[m,n]=size(f); %m-height, n-width

for i=1:height
    for j=1:width
    input_x=i/(height/m);
    input_y=j/(width/n);
     
     x=floor(input_x); %integer part
     y=floor(input_y);
     u=input_x-x; %decimal part
     v=input_y-y;
     p=ceil(input_x);
     q=ceil(input_y);
     
     if x==0 %Up-scale�Ա߽紦����������ʾ�������0������
         x=1;
     end
     
     if y==0
         y=1;
     end 
     
     output_img(i,j)=(1-u)*(1-v)*f(x,y) + (1-u)*v*f(x,q)
                        + u*(1-v)*f(p,y) + u*v*f(p,q);
     
    end
end
     
output_img=uint8(output_img);
imshow(f);
figure,imshow(output_img);
     


end

