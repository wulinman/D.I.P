function [ ] = task5( )
%main function for task 5
    fprintf('image\t\t\tpsnr\t\tssim\n');
    count=1;
    p=zeros(14, 1);
    s=zeros(14, 1);
    for images = dir('./Set14/*.bmp')'
        input_img=imread(strcat('./Set14/',images.name));
        
        %对图像进行超分辨处理
       output_img=superResolution(input_img);
       %imwrite(output_img, strcat('../results/task5/',images.name));

        p(count)=PSNR(input_img, output_img);
        s(count)=SSIM(input_img, output_img);
        fprintf(strcat(images.name,'\t\t',num2str(p(count)),'\t',num2str(s(count)),'\n'));
        count=count+1;
    end
    fprintf(strcat('average\t\t',num2str(mean(p)),'\t',num2str(mean(s)),'\n'));
end

