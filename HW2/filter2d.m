function [ output_img ] = filter2d( input_img, filter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

origin=imread(input_img);
f=double(origin);
[m,n]=size(f); %m-height, n-width
[s,t]=size(filter);
ss=(s-1)/2; %����-1��/2
tt=(t-1)/2; %����-1��/2

%�ж�����ϵ���������Ǹ�
if (filter(ss+1,tt+1)>= 0) c=1;
else c=-1;
end


for i=1:m
    for j=1:n
        sum=0;
        for a=-ss:ss
            for b=-tt:tt
                %if (i+a<1 || i+a>m || j+b<1 || j+b>n)
                %�Ƿ�Խ�磬Խ����򵱳�0
                 if (i+a>=1 && i+a<=m && j+b>=1 && j+b<=n)
                     sum=sum+f(i+a,j+b)*filter(ss+1+a,tt+1+b);
                 else sum=sum+0;       
                 end
            end
        end
        output_img(i,j)=c*sum;
    end
end

output_img=uint8(output_img);
imshow(origin);
figure,imshow(output_img);
end

