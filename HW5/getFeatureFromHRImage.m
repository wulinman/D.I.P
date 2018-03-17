function [ lr_features, hr_features ] = getFeatureFromHRImage(hr_img, sf, sigma )
%get LR patches
%��LRͼ������ȡLR��
%lr_img-LRͼ��hr_img-HRͼ��lr_size-LR��Ĵ�С��sf-��������

lr_img = generateLRImage(hr_img, sf, sigma);
lr_img=double(lr_img);
hr_img=double(hr_img);
[m,n]=size(lr_img); %m-height, n-width

lr_size=7;
half=(lr_size-1)/2; %half lr patch size

%lr��hr patch������
total=(m-lr_size+1)*(n-lr_size+1);
lr_patches=zeros(total, lr_size^2-4);
lr_features=zeros(total, lr_size^2-4);
hr_patches=zeros(total, (3*sf)^2);
hr_features=zeros(total, (3*sf)^2);
count=1; %��¼��ǰ��ȡ�Ŀ�����

%��������lr_patch�����ĵ�
for i = 1+half : m-half
    for j = 1+half : n-half
        
     %��LRͼ������ȡLR��   
     lr_temp=lr_img(i-half : i+half, j-half : j+half);
     %ת��size^2x1�ľ���
     lr_temp=reshape(lr_temp,[],1);
     
     %��lr patch�ĸ��ǽ��вü�
     lr_crop(1:lr_size-2)=lr_temp(2:lr_size-1);
     lr_crop(lr_size-1: (lr_size)*(lr_size-1)-2)=lr_temp(lr_size+1 : (lr_size)*(lr_size-1));
     lr_crop((lr_size)*(lr_size-1)-1: lr_size^2-4)=lr_temp((lr_size)*(lr_size-1)+2: lr_size^2-1);
     
     %�浽LR�鼯�ϵĶ�Ӧ����
     %lr_patches(count, :)=lr_crop;
     
     %��ȡLR����������Ӧ����
     lr_features(count,:)=lr_crop-mean(lr_crop);
     
     %��HRͼ������ȡ��ӦLR���HR�����������
     first_row = (i-2)*sf+1;
     last_row = (i+1)*sf;
     first_col = (j-2)*sf+1;
     last_col = (j+1)*sf;
     hr_temp = hr_img(first_row : last_row, first_col : last_col);
     hr_temp = reshape(hr_temp, [], 1);
     
     %�浽HR�鼯�ϵĶ�Ӧ����
     %hr_patches(count, :)=hr_temp;     
     
      %��ȡHR����������Ӧ����
     hr_features(count,:)=hr_temp-mean(lr_crop);
     
     count=count+1;
    end
end

end

