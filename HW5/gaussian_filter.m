function [ output ] = gaussian_filter( size, sigma )
%UNTITLED2 此处显示有关此函数的摘要
%size-滤波器的边长
%sigma-高斯滤波的标准差

center=(size-1)/2+1;
for i=1:size
    for j=1:size
        rr=(i-center)^2+(j-center)^2; %r的平方，r即为该点到中心点的距离
        output(i,j)=(exp(-rr/(2*sigma^2))/(2*pi*sigma^2));
    end
end

%归一化
output=output/sum(sum(output));
end

