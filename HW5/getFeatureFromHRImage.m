function [ lr_features, hr_features ] = getFeatureFromHRImage(hr_img, sf, sigma )
%get LR patches
%从LR图像中提取LR块
%lr_img-LR图像，hr_img-HR图像，lr_size-LR块的大小，sf-缩放因子

lr_img = generateLRImage(hr_img, sf, sigma);
lr_img=double(lr_img);
hr_img=double(hr_img);
[m,n]=size(lr_img); %m-height, n-width

lr_size=7;
half=(lr_size-1)/2; %half lr patch size

%lr和hr patch的总数
total=(m-lr_size+1)*(n-lr_size+1);
lr_patches=zeros(total, lr_size^2-4);
lr_features=zeros(total, lr_size^2-4);
hr_patches=zeros(total, (3*sf)^2);
hr_features=zeros(total, (3*sf)^2);
count=1; %记录当前提取的块的序号

%遍历所有lr_patch的中心点
for i = 1+half : m-half
    for j = 1+half : n-half
        
     %在LR图像中提取LR块   
     lr_temp=lr_img(i-half : i+half, j-half : j+half);
     %转成size^2x1的矩阵
     lr_temp=reshape(lr_temp,[],1);
     
     %对lr patch四个角进行裁剪
     lr_crop(1:lr_size-2)=lr_temp(2:lr_size-1);
     lr_crop(lr_size-1: (lr_size)*(lr_size-1)-2)=lr_temp(lr_size+1 : (lr_size)*(lr_size-1));
     lr_crop((lr_size)*(lr_size-1)-1: lr_size^2-4)=lr_temp((lr_size)*(lr_size-1)+2: lr_size^2-1);
     
     %存到LR块集合的对应行中
     %lr_patches(count, :)=lr_crop;
     
     %提取LR块特征到对应行中
     lr_features(count,:)=lr_crop-mean(lr_crop);
     
     %在HR图像中提取对应LR块的HR块的中心区域
     first_row = (i-2)*sf+1;
     last_row = (i+1)*sf;
     first_col = (j-2)*sf+1;
     last_col = (j+1)*sf;
     hr_temp = hr_img(first_row : last_row, first_col : last_col);
     hr_temp = reshape(hr_temp, [], 1);
     
     %存到HR块集合的对应行中
     %hr_patches(count, :)=hr_temp;     
     
      %提取HR块特征到对应行中
     hr_features(count,:)=hr_temp-mean(lr_crop);
     
     count=count+1;
    end
end

end

