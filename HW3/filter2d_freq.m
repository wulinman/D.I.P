function [ output_img ] = filter2d_freq( input_img,filter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Attention
%注意：输入拉普拉斯滤波器时，输入原始滤波器矩阵无法得到锐化结果
%需要按照拉普拉斯锐化公式进行手动计算，再输入结果滤波器矩阵
%实验报告中有详细说明

input_img=double(imread(input_img));
[m,n]=size(input_img); %m-height, n-width
[s,t]=size(filter);

%padding
P=m+s;
Q=n+t;

%padding for f and h
f=input_img;
h=filter;
for i=1:P
    for j=1:Q
        if (i>m||j>n) 
            f(i,j)=0;
        end
        if (i>s||j>t) 
            h(i,j)=0;
        end
    end
end

%DFT for f (input_img)

%some temp matrixs
G1=zeros(P,Q);
G2=zeros(P,Q);
G3=zeros(P,Q);

%initialize F,H,output_img
F=zeros(P,Q);
H=zeros(P,Q);
output_img=zeros(P,Q);

for x=1:P
    for v=1:Q
        G1(x,v)=0;
        G2(x,v)=0;
        for y=1:Q
            G1(x,v)=G1(x,v)+f(x,y)*exp(-1i*2*pi*v*y/Q);
            G2(x,v)=G2(x,v)+h(x,y)*exp(-1i*2*pi*v*y/Q);
        end
    end
end

for u=1:P
    for v=1:Q
        F(u,v)=0;
        H(u,v)=0;
        for x=1:P
            F(u,v)=F(u,v)+G1(x,v)*exp(-1i*2*pi*u*x/P);
            H(u,v)=H(u,v)+G2(x,v)*exp(-1i*2*pi*u*x/P);
           % product(u,v)=F(u,v)*H(u,v);
        end
    end
end

product=F.*H;

%IDFT for the product
    for x=1:P
        for v=1:Q
            G3(x,v)=0;
            for y=1:Q
                G3(x,v)=G3(x,v)+product(x,y)*exp(1i*2*pi*v*y/Q);
            end
        end
    end
    
    for u=1:P
        for v=1:Q
            output_img(u,v)=0;
            for x=1:P
                output_img(u,v)=output_img(u,v)+G3(x,v)*exp(1i*2*pi*u*x/P)/(P*Q);
            end
        end
    end
    
output_img=uint8(output_img);
imshow(output_img);
end


