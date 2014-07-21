function MY=mergeY(Y)
m=size(Y,1);
n=size(Y,2);

MY=zeros(m,n-1);
for i=1:m
    index=find(Y(i,:)==1);
    if index==1||index==2
        MY(i,1)=1;
    else
        MY(i,index-1)=1;
    end
end