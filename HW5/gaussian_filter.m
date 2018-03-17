function [ output ] = gaussian_filter( size, sigma )
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%size-�˲����ı߳�
%sigma-��˹�˲��ı�׼��

center=(size-1)/2+1;
for i=1:size
    for j=1:size
        rr=(i-center)^2+(j-center)^2; %r��ƽ����r��Ϊ�õ㵽���ĵ�ľ���
        output(i,j)=(exp(-rr/(2*sigma^2))/(2*pi*sigma^2));
    end
end

%��һ��
output=output/sum(sum(output));
end

