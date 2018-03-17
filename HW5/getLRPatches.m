function [ lr_features, lr_means ] = getLRPatches( lr_img)
%get LR patches feature from test LR image

lr_img=double(lr_img);
[m,n]=size(lr_img); %m-height, n-width

lr_size=7;
half=(lr_size-1)/2; %half lr patch size

%lr������
total=(m-lr_size+1)*(n-lr_size+1);
lr_features=zeros(total, lr_size^2-4);
lr_means=zeros(total, 1);

count=1; %��¼��ǰ��ȡ�Ŀ�����

%��������lr_patch�����ĵ�
for i = 1+half : m-half
    for j = 1+half : n-half
        
     %��LRͼ������ȡLR��   
     lr_temp=lr_img(i-half : i+half, j-half : j+half);
     %ת��size^2x1�ľ���
     lr_temp=reshape(lr_temp,[],1);
     
     %��lr patch�ĸ��ǽ��вü�
    % lr_crop(1:lr_size-2)=lr_temp(2:lr_size-1);
    % lr_crop(lr_size-1: (lr_size)*(lr_size-1)-2)=lr_temp(lr_size+1 : (lr_size)*(lr_size-1));
    % lr_crop((lr_size)*(lr_size-1)-1: lr_size^2-4)=lr_temp((lr_size)*(lr_size-1)+2: lr_size^2-1);
    lr_crop=lr_temp([2:6 8:42 44:48]);
     
     %�浽LR�鼯�ϵĶ�Ӧ����
     %lr_patches(count, :)=lr_crop;
     
     %��ȡLR����������Ӧ����
     lr_features(count,:)=lr_crop-mean(lr_crop);
     
     lr_means(count,:)=mean(lr_crop);
     
     count=count+1;
    end
end

end

