function NeuralPredict(ModelPath,PredictdataPath)

dirOutput=dir(strcat('./',ModelPath));
ModelFileName={dirOutput.name}';
ModelFileName=filterFileName(ModelFileName);
mn=length(ModelFileName);

dirOutput=dir(strcat('./',PredictdataPath));
PredictFileName={dirOutput.name}';
PredictFileName=filterFileName(PredictFileName);
pn=length(PredictFileName);


for i=1:mn
    %fprintf('%s %s %s',ModelFileName{i},PredictFileName{(i-1)*3+1},PredictFileName{(i-1)*3+3});
    load(strcat(ModelPath,ModelFileName{i})); % load model
    load(strcat(PredictdataPath,PredictFileName{(i-1)*3+1})); % load X
    load(strcat(PredictdataPath,PredictFileName{(i-1)*3+3})); % load Y
    X=X';
    NEWY=NEWY';
    outputs = net(X);
    [c,cm,ind,per]=confusion(NEWY,outputs);

    
    % print result
    %calculate true positive,false positive,false negative, true negative
    index=strfind(ModelFileName{i},'_');
    str=ModelFileName{i}(1:index-1);
    fprintf('%s\t',str);
    tpr=cm(1,1)/(cm(1,1)+cm(1,2));
    fpr=cm(2,1)/(cm(2,1)+cm(2,2));
    fnr=cm(1,2)/(cm(1,1)+cm(1,2));
    tnr=cm(2,2)/(cm(2,1)+cm(2,2));
    fprintf('true positive:%f\t',tpr);
    fprintf('false positive:%f\t',fpr);
    fprintf('false negative:%f\t',fnr);
    fprintf('true negative:%f\t',tnr);
    fprintf('accuracy:%f\n',(1-c)*100);
end

end