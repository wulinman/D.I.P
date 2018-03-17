function [ lr_img ] = generateLRImage( hr_img,factor,sigma )
%function for LR image generating
%生成LR图像的函数
%hr_img-高分辨率图像， factor-缩放因子， sigma-高斯核标准差

hr_img=double(hr_img);
[h,w,d]=size(hr_img);

%对HR图像进行修剪，使其边长能整除factor
htrim=h-mod(h,factor);
wtrim=w-mod(w,factor);
trim_img=hr_img(1:htrim,1:wtrim,1:d);

%生成高斯核
kernel_size=ceil(sigma*3)*2+1;
kernel=gaussian_filter(kernel_size,sigma);

%高斯核与裁剪图像做卷积，得到模糊图像
blur_img=conv2d(trim_img,kernel);
blur_img=double(blur_img);%得到的结果为uint8类型，需转成double

%对模糊图像进行下采样，得到LR
lr_img=bicubic(blur_img,htrim/factor,wtrim/factor);
end

