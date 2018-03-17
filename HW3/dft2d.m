function [ output_img ] = dft2d( input_img,flags)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

f=double(imread(input_img));
[m,n]=size(f); %m-height, n-width

if (flags==0)
    %中心化
    for x=1:m
        for y=1:n
            f(x,y)=f(x,y)*(-1).^(x+y);
        end
    end
end

%DFT
G=zeros(m,n);
F=zeros(m,n);
for x=1:m
    for v=1:n
        G(x,v)=0;
        for y=1:n
            G(x,v)=G(x,v)+f(x,y)*exp(-1i*2*pi*v*y/n);
        end
    end
end

for u=1:m
    for v=1:n
        F(u,v)=0;
        for x=1:m
            F(u,v)=F(u,v)+G(x,v)*exp(-1i*2*pi*u*x/m);
        end
    end
end

if (flags==0)
    %取膜得到谱
    F=abs(F);

    %log变换
    F=log(1+F);

    %scaling
    max=0;
    for x=1:m
        for y=1:n
            if (F(x,y)>max) max=F(x,y);
            end
        end
    end
    rate = 255/max;
    F=F*rate;

    output_img=uint8(F);
    imshow(output_img);
end

%IDFT
if (flags==1)
    H=zeros(m,n);
    output_img=zeros(m,n);
    for x=1:m
        for v=1:n
            H(x,v)=0;
            for y=1:n
                H(x,v)=H(x,v)+F(x,y)*exp(1i*2*pi*v*y/n);
            end
        end
    end
    
    max=0;
    for u=1:m
        for v=1:n
            output_img(u,v)=0;
            for x=1:m
                output_img(u,v)=output_img(u,v)+H(x,v)*exp(1i*2*pi*u*x/m)/(m*n);
                if (output_img(u,v)>max) 
                    max=output_img(u,v);
                end
            end
        end
    end
   
   %get real part
   output_img=real(output_img);
   
   %scaling 
    rate = 255/max;
    output_img=output_img*rate;
    
    output_img=uint8(output_img);
    imshow(output_img);
end

end

