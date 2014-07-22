function [X,Y]=makeTestdata(savepath,posPath)
posExample=load(posPath);
poslabel=1;
neglabel=2;
numPos=size(posExample,1); %number of pos example
k=size(posExample,2); %number of features
numNeg=numPos;

index=strfind(posPath,'/');
basePath=posPath(1:index);
dirOutput=dir(basePath);
fileNames={dirOutput.name}';
fileNames=fileNames(3:end);
posName=posPath(index+1:end);

avgnum=floor(numNeg/(length(fileNames)-1));

fprintf('%s\n',posName);
% add positive examples
X=[];
Y=[];
X=[X;posExample];
Y=[Y;ones(numPos,1)*poslabel];

for i=1:length(fileNames)
    
    if strcmpi(fileNames{i},posName)
        continue;
    end
    data=load([basePath fileNames{i}]);
    num=avgnum;
    if num>size(data,1)
        num=size(data,1);
    end
    X=[X;data(1:num,:)];
    Y=[Y;ones(num,1)*neglabel];
end

% randomlize data
r=randperm(size(X,1));
X=X(r,:);
Y=Y(r);

filenameX=[savepath,posName,'_X.mat'];
filenameY=[savepath,posName,'_Y.mat'];
save(filenameX,'X');
save(filenameY,'Y');

convertY(filenameY);

end
