function [ output_img ] = conv2d( input_img, filter )
%convolution function
%卷积函数(padding补最接近的值）
%Input array values outside the bounds of the array
%are assumed to equal the nearest array border value.
 

f=double(input_img);
[m,n]=size(f); %m-height, n-width
[s,t]=size(filter);
ss=(s-1)/2; %（高-1）/2
tt=(t-1)/2; %（宽-1）/2

output_img=zeros(m,n);
for i=1:m
    for j=1:n
        sum=0;
        for a=-ss:ss
            for b=-tt:tt
                %if (i+a<1 || i+a>m || j+b<1 || j+b>n)
                
                temp=[i+a,j+b];
                %横纵坐标都无越界
                 %if (i+a>=1 && i+a<=m && j+b>=1 && j+b<=n)
                 %    sum=sum+f(i+a,j+b)*filter(ss+1+a,tt+1+b);
                 %end
                 
                 if (temp(1)<1)
                     temp(1)=1;
                 end
                 if (temp(1)>m)
                     temp(1)=m;
                 end
                 if (temp(2)<1)
                     temp(2)=1;
                 end
                 if (temp(2)>n)
                     temp(2)=n;
                 end
                 sum=sum+f(temp(1),temp(2))*filter(ss+1+a,tt+1+b);     
            end
        end
        output_img(i,j)=sum;
    end
end

output_img=uint8(output_img);
%imshow(uint8(f));
%figure,imshow(output_img);

end

