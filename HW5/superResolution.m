function [ output_img ] = superResolution( input_img)
%function of super resolution
%output HR image from super resolution
    origin=input_img;
    sf = 3;
    [h,w,d]=size(input_img);
    %������ͼ������޼���ʹ��߳�������factor
    htrim=h-mod(h,sf);
    wtrim=w-mod(w,sf);
    input_img=input_img(1:htrim,1:wtrim,1:d);
    
    %�²����õ�����ͼ���LRͼ��
    lr_img=zeros(htrim/sf, wtrim/sf,d);

    for i=1:d
        lr_img(:,:,i)=generateLRImage(input_img(:,:,i), sf, 1.2);
    end
    

    output_img=zeros(h,w,d);
    %���ó��ֱ����㷨�����ϲ���
    if (d==1)
        output_img=generateResultImage(lr_img, h, w);
        
    end
    if (d>1)
        lr_img=rgb2ycbcr(uint8(lr_img)); %uint8
        lr_img=double(lr_img);
        %U,Vͨ��ʹ��bicubic�����ϲ���
        output_img(:,:,2)=bicubic(lr_img(:,:,2), h, w);
        output_img(:,:,3)=bicubic(lr_img(:,:,3), h, w);

        %Yͨ��ʹ�ó��ֱ����㷨�����ϲ���
        output_img(:,:,1)=generateResultImage(lr_img(:,:,1), h, w);
        output_img=ycbcr2rgb(uint8(output_img));
    end
    %figure, imshow(output_img);
    %P=PSNR(origin,output_img);
    %S=SSIM(origin,output_img);
end

