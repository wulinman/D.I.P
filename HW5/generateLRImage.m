function [ lr_img ] = generateLRImage( hr_img,factor,sigma )
%function for LR image generating
%����LRͼ��ĺ���
%hr_img-�߷ֱ���ͼ�� factor-�������ӣ� sigma-��˹�˱�׼��

hr_img=double(hr_img);
[h,w,d]=size(hr_img);

%��HRͼ������޼���ʹ��߳�������factor
htrim=h-mod(h,factor);
wtrim=w-mod(w,factor);
trim_img=hr_img(1:htrim,1:wtrim,1:d);

%���ɸ�˹��
kernel_size=ceil(sigma*3)*2+1;
kernel=gaussian_filter(kernel_size,sigma);

%��˹����ü�ͼ����������õ�ģ��ͼ��
blur_img=conv2d(trim_img,kernel);
blur_img=double(blur_img);%�õ��Ľ��Ϊuint8���ͣ���ת��double

%��ģ��ͼ������²������õ�LR
lr_img=bicubic(blur_img,htrim/factor,wtrim/factor);
end

