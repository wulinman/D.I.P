function [ output_img ] = filter2d( input_img, filter )

%returns only those parts of the correlation
%that are computed without the zero-padded edges, size(Y) < size(X)
f=double(input_img);
[m,n]=size(f); %m-height, n-width
[s,t]=size(filter);
ss=(s-1)/2; %£¨¸ß-1£©/2
tt=(t-1)/2; %£¨¿í-1£©/2

for i=1+ss:m-ss
    for j=1+tt:n-tt
        sum=0;
        for a=-ss:ss
            for b=-tt:tt
                sum=sum+f(i+a,j+b)*filter(ss+1+a,tt+1+b);       
            end
        end
        output_img(i-ss,j-tt)=sum;
    end
end

end

