function NEWY=convertY(file)
load(file);
n=length(Y);
NEWY=zeros(n,2);
for i=1:n
    if Y(i)==1
        NEWY(i,1)=1;
    else
        NEWY(i,2)=1;
    end
end
index=strfind(file,'.');
newfile=strcat(file(1:index-1),'N.mat');
save(newfile,'NEWY');
end