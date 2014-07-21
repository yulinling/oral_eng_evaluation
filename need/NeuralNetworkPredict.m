function NeuralNetworkPredict(ModelPath,PredictdataPath)

ModelPath=strcat('../',ModelPath);
dirOutput=dir(ModelPath);
ModelFileName={dirOutput.name}';
ModelFileName=ModelFileName(3:end);
mn=length(ModelFileName);

PredictdataPath=strcat('../',PredictdataPath);
dirOutput=dir(PredictdataPath);
PredictFileName={dirOutput.name}';
PredictFileName=PredictFileName(3:end);
pn=length(PredictFileName);

for i=1:mn
    load(strcat(ModelPath,ModelFileName{i})); % load model
    load(strcat(PredictdataPath,PredictFileName{(i-1)*3+1})); % load X
    load(strcat(PredictdataPath,PredictFileName{(i-1)*3+2})); % load Y
    %predict 
    pred = predict(W1, W2, X);
    accuracy=mean(double(pred == Y))*100;
    
    index=strfind(ModelFileName{i},'_');
    str=[ModelFileName{i}(1:index-1) ' ' num2str(accuracy)];
    fprintf('%s\n',str);
end

end