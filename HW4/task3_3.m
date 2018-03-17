function [] = task3_3( )
%main function for question 2.4.3
input_img=imread('./image/14.png');
input_img=double(input_img);
%normalized=input_img./255;
normalized=input_img;
R=normalized(:,:,1);
G=normalized(:,:,2);
B=normalized(:,:,3);
[m,n]=size(R); %m-height, n-width

%求H
theta=zeros(m,n);
%theta = acos( 0.5*((R-G)+(R-B)) / (sqrt((R-G).^2+(R-B).*(G-B))) );
H=zeros(m,n);
for i=1:m
    for j=1:n
        theta(i,j)=acos( 0.5*((R(i,j)-G(i,j))+(R(i,j)-B(i,j))) / (sqrt((R(i,j)-G(i,j))^2+(R(i,j)-B(i,j))*(G(i,j)-B(i,j)))+eps));
        if(B(i,j)<=G(i,j))
            H(i,j)=theta(i,j);
        else H(i,j)=(2*pi-theta(i,j));
        end
    end
end
%H=H*255;

%求S
S=zeros(m,n);
for i=1:m
    for j=1:n
        S(i,j)=1-3/(R(i,j)+G(i,j)+B(i,j))*min([R(i,j),G(i,j),B(i,j)]);
    end
end
%S=S*255;

%求I
%I=(1/3)*(R+G+B)*255;
I=(1/3)*(R+G+B);
I=uint8(I);
I=double(equalize_hist(I));
%equalize_I=equalize_I/255; %对均衡后的I进行归一化，方便后面的计算

%HSI转RGB
temp=zeros(m,n);
R2=zeros(m,n);
G2=zeros(m,n);
B2=zeros(m,n);
for i=1:m
    for j=1:n
        if(H(i,j)>=0 && H(i,j)<(2/3)*pi)
            temp(i,j)=H(i,j);
            B2(i,j)=I(i,j)*(1-S(i,j));
            R2(i,j)=I(i,j)*(1+S(i,j)*cos(temp(i,j))/cos(pi/3-temp(i,j)));
            G2(i,j)=3*I(i,j)-(R2(i,j)+B2(i,j));
        end
        if(H(i,j)>=(2/3)*pi && H(i,j)<(4/3)*pi)
            temp(i,j)=H(i,j)-(2/3)*pi;
            R2(i,j)=I(i,j)*(1-S(i,j));
            G2(i,j)=I(i,j)*(1+S(i,j)*cos(temp(i,j))/cos(pi/3-temp(i,j)));
            B2(i,j)=3*I(i,j)-(R2(i,j)+G2(i,j));
        end
        if(H(i,j)>=(4/3)*pi && H(i,j)<=2*pi)
            temp(i,j)=H(i,j)-(4/3)*pi;
            G2(i,j)=I(i,j)*(1-S(i,j));
            B2(i,j)=I(i,j)*(1+S(i,j)*cos(temp(i,j))/cos(pi/3-temp(i,j)));
            R2(i,j)=3*I(i,j)-(G2(i,j)+B2(i,j));
        end
    end
end

output_img=cat(3,R2,G2,B2);
output_img=uint8(output_img);

subplot(1,2,1);
imshow(uint8(input_img));   %原图
title('origin image');

subplot(1,2,2);
imshow(output_img);
title('result image');

%figure,imshow(output_img);

end

