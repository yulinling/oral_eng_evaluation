function NEWY=convertY(file,k)
load(file);
n=length(Y);
NEWY=zeros(n,k);
for i=1:n
    NEWY(i,Y(i))=1;
end
index=strfind(file,'.');
newfile=strcat(file(1:index-1),'N.mat');
save(newfile,'NEWY');
end