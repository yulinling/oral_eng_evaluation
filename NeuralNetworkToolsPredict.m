function NeuralPredict(ModelPath,PredictdataPath)

dirOutput=dir(strcat('./',ModelPath));
ModelFileName={dirOutput.name}';
ModelFileName=ModelFileName(3:end);
mn=length(ModelFileName);

dirOutput=dir(strcat('./',PredictdataPath));
PredictFileName={dirOutput.name}';
PredictFileName=PredictFileName(3:end);
pn=length(PredictFileName);

for i=1:mn
    load(strcat(ModelPath,ModelFileName{i})); % load model
    load(strcat(PredictdataPath,PredictFileName{(i-1)*3+1})); % load X
    load(strcat(PredictdataPath,PredictFileName{(i-1)*3+3})); % load Y
    X=X';
    NEWY=NEWY';
    outputs = net(X);
    [c,cm,ind,per]=confusion(NEWY,outputs);

    index=strfind(ModelFileName{i},'_');
    str=[ModelFileName{i}(1:index-1) ' ' num2str((1-c)*100)];
    fprintf('%s\n',str);
end

end