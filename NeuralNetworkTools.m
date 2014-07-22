function NeuralNetworkTools(path)

dirOutput=dir(strcat('./',path));
fileNames={dirOutput.name}';
n=length(fileNames);
maxNumber=100000;
for i=3:3:n
    load(strcat(path,fileNames{i}));
    load(strcat(path,fileNames{i+2}));
    num=size(X,1);
    if num>maxNumber
        num=maxNumber;
    end
    X=X(1:num,:);
    NEWY=NEWY(1:num,:);
    X=X';
    NEWY=NEWY';
    
    maxValue=0;
    for j=1:3
        % Create a Pattern Recognition Network
        hiddenLayerSize = 27;
        net = patternnet(hiddenLayerSize);

        % Setup Division of Data for Training, Validation, Testing
        net.divideParam.trainRatio = 70/100;
        net.divideParam.valRatio = 15/100;
        net.divideParam.testRatio = 15/100;

        % Train the Network
        net = train(net,X,NEWY);

        % Test the Network
        outputs = net(X);
        [c,cm,ind,per]=confusion(NEWY,outputs);
        
        % print result
        index=strfind(fileNames{i},'_');
        str=[fileNames{i}(1:index-1) ' ' num2str((1-c)*100)];
        fprintf('%s\n',str);
        %fprintf('%s: all accuracy is %f%%\n',fileNames{i},(1-c)*100);
        
        % save model
        if maxValue<(1-c)*100
            save(['model/' fileNames{i}(1:index-1) '_net'],'net');
            maxValue=(1-c)*100;
        end
    end
end

% % Create a Pattern Recognition Network
% hiddenLayerSize = 27;
% net = patternnet(hiddenLayerSize);
% 
% 
% % Setup Division of Data for Training, Validation, Testing
% net.divideParam.trainRatio = 70/100;
% net.divideParam.valRatio = 15/100;
% net.divideParam.testRatio = 15/100;
% 
% 
% % Train the Network
% [net,tr] = train(net,inputs,targets);
% 
% % Test the Network
% outputs = net(inputs);
% errors = gsubtract(targets,outputs);
% performance = perform(net,targets,outputs)
% 
% % View the Network
% view(net)
% 
% % Plots
% % Uncomment these lines to enable various plots.
% %figure, plotperform(tr)
% %figure, plottrainstate(tr)
% %figure, plotconfusion(targets,outputs)
% %figure, ploterrhist(errors)
