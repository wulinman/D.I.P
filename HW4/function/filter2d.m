function [ output_img ] = filter2d( input_img, filter, Q )
%input_img:input image
%Q: variable of contraharmonic mean filter

%origin=imread(input_src);
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
        sum1=0; sum2=0;
        for a=-ss:ss
            for b=-tt:tt
                %是否越界，越界的则当成0
                 if (i+a>=1 && i+a<=m && j+b>=1 && j+b<=n)
                         sum1 = sum1 + (f(i+a,j+b)*filter(ss+1+a,tt+1+b))^(Q+1);
                         sum2 = sum2 + (f(i+a,j+b)*filter(ss+1+a,tt+1+b))^Q;
                 end
            end
        end
            output_img(i,j)=sum1/sum2;
    end
end

output_img=uint8(output_img);

end

