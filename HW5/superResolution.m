function [ output_img ] = superResolution( input_img)
%function of super resolution
%output HR image from super resolution
    origin=input_img;
    sf = 3;
    [h,w,d]=size(input_img);
    %对输入图像进行修剪，使其边长能整除factor
    htrim=h-mod(h,sf);
    wtrim=w-mod(w,sf);
    input_img=input_img(1:htrim,1:wtrim,1:d);
    
    %下采样得到测试图像的LR图像
    lr_img=zeros(htrim/sf, wtrim/sf,d);

    for i=1:d
        lr_img(:,:,i)=generateLRImage(input_img(:,:,i), sf, 1.2);
    end
    

    output_img=zeros(h,w,d);
    %利用超分辨率算法进行上采样
    if (d==1)
        output_img=generateResultImage(lr_img, h, w);
        
    end
    if (d>1)
        lr_img=rgb2ycbcr(uint8(lr_img)); %uint8
        lr_img=double(lr_img);
        %U,V通道使用bicubic进行上采样
        output_img(:,:,2)=bicubic(lr_img(:,:,2), h, w);
        output_img(:,:,3)=bicubic(lr_img(:,:,3), h, w);

        %Y通道使用超分辨率算法进行上采样
        output_img(:,:,1)=generateResultImage(lr_img(:,:,1), h, w);
        output_img=ycbcr2rgb(uint8(output_img));
    end
    %figure, imshow(output_img);
    %P=PSNR(origin,output_img);
    %S=SSIM(origin,output_img);
end

