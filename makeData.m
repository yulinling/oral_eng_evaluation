function [X,Y,number]=makeData(savepath,pos,varargin)
posExample=load(pos);
poslabel=1;
neglabel=2;
numPos=size(posExample,1); %number of pos example
k=size(posExample,2); %number of features
partition=0.5; % the ratio between mix and unmix example
numNeg=floor(numPos*partition);
numParam=numel(varargin);
numFiles=floor(numParam/2);
negExamples=cell(1,numFiles);
ratioes=zeros(1,numFiles);
fileNames=cell(1,numFiles);
for i=1:numParam
    if mod(i,2)==1
        negExamples{floor(i/2)+1}=load(varargin{i});
        index=strfind(varargin{i},'/');
        fileNames{floor(i/2)+1}=varargin{i}(index+1:end);
    else
        ratioes(floor(i/2))=varargin{i};
    end
end

ratioes=ratioes./sum(ratioes);

% 打印数据组成
str='';
for i=1:numFiles
    temp=[fileNames{i} ':' num2str(ratioes(i)*100)];
    str=[str temp ' '];
end
fprintf('%s\n',str);

numNegtemp=floor(ratioes.*numNeg);
for i=1:length(numNegtemp)
    if numNegtemp(i)>size(negExamples{i},1)
        numNegtemp(i)=size(negExamples{i},1);
    end
end

numNeg=sum(numNegtemp);
for i=1:numFiles
    negExamples{i}=negExamples{i}(1:numNegtemp(i),:);
end

X=[];
Y=[];

X=[X;posExample];
Y=[Y;ones(numPos,1)*poslabel];

for i=1:numFiles
    n=size(negExamples{i},1);
    X=[X;negExamples{i}];
    Y=[Y;ones(n,1)*neglabel];
end

clear posExample negExamples;

% 添加非混淆音素的数据
index=strfind(pos,'/');
basePath=pos(1:index);
posName=pos(index+1:end);
dirOutput=dir(basePath);
Allfiles={dirOutput.name}';
Allfiles=Allfiles(3:end);
fileNames=[fileNames,posName];
leftfileNames=setdiff(Allfiles,fileNames);
numleft=floor(numPos*(1-partition));
avgnum=floor(numleft/length(leftfileNames));
for i=1:length(leftfileNames)
    data=load([basePath,leftfileNames{i}]);
    num=avgnum;
    if num>size(data,1)
        num=size(data,1);
    end
    X=[X;data(1:num,:)];
    Y=[Y;ones(num,1)*neglabel];
    clear data;
end

%计算总的样本数量
number=size(X,1);

% randomlize data
r=randperm(size(X,1));
X=X(r,:);
Y=Y(r);

index=strfind(pos,'/');
filenameX=strcat(pos(index+1:end),'_X.mat');
filenameX=strcat(savepath,filenameX);
filenameY=strcat(pos(index+1:end),'_Y.mat');
filenameY=strcat(savepath,filenameY);

save(filenameX,'X');
save(filenameY,'Y');

convertY(filenameY);

end