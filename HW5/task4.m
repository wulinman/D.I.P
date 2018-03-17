function [ ] = task4( )
%main function for task 4
    fprintf('image\t\t\tpsnr\t\tssim\n');
    count=1;
    p=zeros(14, 1);
    s=zeros(14, 1);
    for images = dir('./Set14/*.bmp')'
        input_img=imread(strcat('./Set14/',images.name));
        %m-高， n-宽， v-维度
        [m,n,d]=size(input_img);
        
        %计算出下采样图像的宽和高
        temp_m=round(m/3);
        temp_n=round(n/3);

        %下采样
        temp_img=bicubic(input_img, temp_m, temp_n);
        %上采样
        output_img=bicubic(temp_img, m, n);

        p(count)=PSNR(input_img, output_img);
        s(count)=SSIM(input_img, output_img);
        fprintf(strcat(images.name,'\t\t',num2str(p(count)),'\t',num2str(s(count)),'\n'));
        count=count+1;
    end
    fprintf(strcat('average\t\t',num2str(mean(p)),'\t',num2str(mean(s)),'\n'));
end

