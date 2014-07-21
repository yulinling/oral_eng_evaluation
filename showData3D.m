function showData3D(data,varargin)
% flag: if flag==true normalize else without normalize
% 

X=data(:,1);
Y=data(:,2);
Z=data(:,3);
label=data(:,4);
flag=false;
num=nargin
if nargin>1
    flag=varargin{1};
end

if flag==true
    X=normalize(X);
    Y=normalize(Y);
    Z=normalize(Z);
end

color=['r';'g';'b';'y';'c'];
figure;
xlabel('RankScore');
ylabel('SegDurationScore');
zlabel('GopScore');
for i=1:5
    hold on;
    index=find(label==i);
    scatter3(X(index),Y(index),Z(index),'+',color(i));
end