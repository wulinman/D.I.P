function [ output_img ] = bicubic( input_img, height, width )
%bicubic
%˫���β�ֵ

input_img=double(input_img);
[m,n,d]=size(input_img); %m-height, n-width

output_img=zeros(height,width, d);
%B=zeros(4,4,d);
for k = 1:d
    f=input_img(:,:,k); 
    for i=1:height
        for j=1:width
            %���Ŀ��ͼ���Ŀ��㣨target_x,target_y)
            target_x=i/(height/m);
            target_y=j/(width/n);

            %�ذ��������Ŀ�����ߵĵ�
             x=floor(target_x); %integer part
             y=floor(target_y);

             %Ŀ����С������
             u=target_x-x;
             v=target_y-y;

             %��һ�м�Ϊrow(1)
             row=[x-1,x,x+1,x+2];
             col=[y-1,y,y+1,y+2];

             %Up-scale�Ա߽紦����������ʾ�������0������
             %����������д���
             if row(1)<1
                 %x=2;
                 row(1)=1;
             end
             if row(2)<1
                 %x=2;
                 row(2)=1;
             end
             if row(4)>m
                 %x=m-2;
                 row(4)=m;
             end
             if row(3)>m
                 %x=m-2;
                 row(3)=m;
             end   
             %�Ժ�������д���
             if col(1)<1
                 %x=2;
                 col(1)=1;
             end
             if col(2)<1
                 %x=2;
                 col(2)=1;
             end
             if col(3)>n
                 %x=m-2;
                 col(3)=n;
             end    
             if col(4)>n
                 %x=m-2;
                 col(4)=n;
             end

             %��Ȩ����
             A=[W(1+u),W(u),W(1-u),W(2-u)];
             C=[W(1+v),W(v),W(1-v),W(2-v)];
             B=[f(row(1),col(1)),f(row(1),col(2)),f(row(1),col(3)),f(row(1),col(4));
                f(row(2),col(1)),f(row(2),col(2)),f(row(2),col(3)),f(row(2),col(4));
                f(row(3),col(1)),f(row(3),col(2)),f(row(3),col(3)),f(row(3),col(4));
                f(row(4),col(1)),f(row(4),col(2)),f(row(4),col(3)),f(row(4),col(4));];

            %�õ���ֵ���
            output_img(i,j,k)=A*B*C';
        end
    end
end

output_img=uint8(output_img);
end

