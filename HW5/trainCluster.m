function [ coef ] = trainCluster( )
%function to train cluster center
%训练聚类中心的函数

    sf=3;
    sigma=1.2;
    patches_num=2000000;
    lr_patches=zeros(patches_num,45);
    hr_patches=zeros(patches_num,81);
    lr_height=0;
    
%read img from Training set
    for file = dir('./Train/*.jpg')'
        hr_img=imread(strcat('./Train/',file.name));
        hr_img=double(hr_img);
        [~, ~,d]=size(hr_img);
        if (d>1)
            hr_img=rgb2ycbcr(hr_img);
            hr_img=hr_img(:,:,1);
        end

        %extract feature for clustering
        [lr_features, hr_features]=getFeatureFromHRImage(hr_img, sf, sigma);
        [h1,~]=size(lr_features);
        if (h1 < (patches_num-lr_height))
            lr_patches(lr_height+1 : lr_height+h1, :) = lr_features;
            hr_patches(lr_height+1 : lr_height+h1, :) = hr_features;
            lr_height = lr_height+h1;
        else
            lr_patches(lr_height+1 : patches_num, :) = lr_features(1: patches_num-lr_height, :);
            hr_patches(lr_height+1 : patches_num, :) = hr_features(1: patches_num-lr_height, :);
            lr_height = patches_num;
            break;
        end    
        
    end
        
        %聚类
        cluster_num=512;
        opt=statset('UseParallel',1, 'MaxIter', 250);
        [idx, center] = kmeans(lr_patches(1:250000,:), cluster_num, 'Display', 'Iter', 'Options', opt);
       save ('getcenter.mat', 'center');
       
       %计算系数矩阵
        [idx_len, ~]=size(idx);
        newidx=zeros(patches_num, 1);
        %coef=zeros(~,~,cluster_num);
        %求出该LR patch对应的类
        for i=idx_len+1 : patches_num
            diff = repmat(lr_patches(i,:), [cluster_num, 1]) - center;
            %求出距离的平方（对行求）
            distance_sq = sum((diff.^2), 2); %cluster_num*1
            [~,clusteridx] = min(distance_sq);

            %求出没有参加聚类的LR patch对应的类
            newidx(i) = clusteridx;
        end

       %求出C
       for i= 1 : cluster_num;
           coef(:, :, i) = lr_patches(newidx==i, :)\hr_patches(newidx==i, :);
       end
       save('coef.mat', 'coef');
       
end

