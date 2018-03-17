function [ ssim ] = SSIM( img1, img2 )
%This function returns the SSIM value of input_img1 and input_img2
img1 = double(img1);
img2 = double(img2);

%RGB to YCbCr
[m1,n1,v1]=size(img1);
if(v1>1)
    img1=rgb2ycbcr(img1);
    img1=img1(:,:,1);
end
[m2,n2,v2]=size(img2);
if(v2>1)
    img2=rgb2ycbcr(img2);
    img2=img2(:,:,1);
end

%L��gray level of image
%c1,c2:constant to keep balance
L=255;
k1=0.01;
k2=0.03;
c1=(k1*L)^2;
c2=(k2*L)^2;

%���ɸ�˹�˲���
w=gaussian_filter(11,1.5);

%����������ھ�ֵ�ļ���
ux=filter2d(img1,w);
uy=filter2d(img2,w);

%�����ֵ��ƽ��
ux_sq=ux.*ux;
uy_sq=uy.*uy;

%����������ڷ���ļ���
sx_sq=filter2d(img1.*img1,w)-ux_sq;
sy_sq=filter2d(img2.*img2,w)-uy_sq;

%Э����
sxy=filter2d(img1.*img2,w)-(ux.*uy);

%�������ڵ�ssim�ļ���
ssim_map=(2*ux.*uy+c1).*(2*sxy+c2)./((ux_sq+uy_sq+c1).*(sx_sq+sy_sq+c2));

%�������ͼ��ssim�����ս��
ssim=mean(ssim_map(:));

end

