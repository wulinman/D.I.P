function [ hr_img, count, patches_num ] = generateResultImage( lr_img, height, width )
    %generate HR image from test LR image
    
    sf = 3;
    lr_img=double(lr_img);
    
    %���ӳ�亯����ϵ��
    %coef=getCoef();
    load('coef.mat', 'coef');

    %��þ�������ĵ�
    load('getcenter.mat', 'center');
   %cluster_num= 512;
   [cluster_num,~]=size(center);

    %��lr_img��������
   % [m,n,~]=size(lr_img);
    lr_img=padarray(lr_img, [4,4], 'replicate', 'both');
    [m_pad,n_pad,~]=size(lr_img);

    %n*45 nΪpatch������
    [lr_patches, lr_means]=getLRPatches(lr_img);
    [patches_num, ~]=size(lr_patches);

    %��ʼ��hr_patches
    hr_patches=zeros(patches_num, 81);

    %�����LR patch��Ӧ����
    for i=1:patches_num
       diff = repmat(lr_patches(i,:), [cluster_num, 1]) - center;
        %��������ƽ����������
        distance_sq = sum((diff.^2), 2); %cluster_num*1
        [~,clusteridx] = min(distance_sq);

        %�����Ӧ��HR patch
       hr_patches(i,:) = lr_patches(i,:)*coef(:,:,clusteridx);
    end

    %�ع�HRͼ��
    hr_img=zeros(height+24, width+24);
    lr_size=7;
    half=(lr_size-1)/2; %half lr patch size
    count=1; %��¼�ǵڼ�Ƭpatch
     %m_pad��n_padΪ���غ��LRͼ��ĸߺͿ�
    for i = 1+half : m_pad-half
        for j = 1+half : n_pad-half
            
         r1 = (i-2)*sf+1;
         r2 = (i+1)*sf;
         c1 = (j-2)*sf+1;
         c2 = (j+1)*sf;
         hr_patches(count,:)=hr_patches(count,:)+lr_means(count,:);
         hr_img(r1 : r2, c1 : c2) = hr_img(r1 : r2, c1 : c2)+reshape(hr_patches(count,:),9,9);
         count=count+1;       
        end
    end   

    %���ͼ���е�ÿһ����������9��
    hr_img=hr_img(13:12+height, 13:12+width)/9;
    hr_img=uint8(hr_img);
  
end

