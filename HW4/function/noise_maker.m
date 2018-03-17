function [ output_img ] = noise_maker( input_img, flag, a, b )

%flag: 0-高斯噪声， 1-椒盐噪声
%a: 高斯噪声的均值 或 椒噪声的概率
%b: 高斯噪声的标准差 或 盐噪声的概率

%origin=imread(input_img);
[m,n,z]=size(input_img); %m-height, n-width
if (z>1)
    input_img=rgb2gray(input_img);
end
f=double(input_img);

%generate gaussian noise
if (flag == 0)
    u1=rand(m,n);
    u2=rand(m,n);
    noise = sqrt(-2*log(u1)).*cos(2*pi*u2);
    noise = a + b*noise;
    %noise2 = normrnd(a,b,[m,n]);
    output_img= uint8(f + noise);
end

%generate salt and pepper noise
if (flag == 1)
    pepper_num=fix(a*m*n);
    salt_num=fix(b*m*n);
    is_pepper=zeros(m,n); %if f(x,y) is pepper noise, is_pepper(x,y)=1
    is_salt=zeros(m,n);
    
    %generate pepper noise
    for i=1:pepper_num
        noise_x=fix(rand()*m);
        noise_y=fix(rand()*n);
        if (noise_x==0)
            noise_x=1;
        end
        if (noise_y==0)
            noise_y=1;
        end
        if (is_pepper(noise_x,noise_y)==0)
            is_pepper(noise_x,noise_y) = 1;
            f(noise_x,noise_y)=0;
        else i=i-1;
        end       
    end
    
    %generate salt noise
    for i=1:salt_num
        noise_x=round(rand()*m);
        noise_y=round(rand()*n);
        if (noise_x==0)
            noise_x=1;
        end
        if (noise_y==0)
            noise_y=1;
        end
        if (is_pepper(noise_x,noise_y)==0 && is_salt(noise_x,noise_y)==0)
            is_salt(noise_x,noise_y) = 1;
            f(noise_x,noise_y)=255;
        else i=i-1;
        end
        
    end
    output_img=uint8(f);
end        
imshow(output_img);

end

