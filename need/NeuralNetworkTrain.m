function NeuralNetworkTrain(path)

dirOutput=dir(strcat('./',path));
fileNames={dirOutput.name}';
fileNames=fileNames(3:end);
n=length(fileNames);

for i=1:3:n
    load(strcat(path,fileNames{i}));
    load(strcat(path,fileNames{i+1}));
    maxVal=0;
    for j=1:3
        input_layer_size  = size(X,2);
        hidden_layer_size = 27;
        num_labels = 2;
        
        numTrain = round(numel(Y)/10*8);
        trainData   = X(1:numTrain,:);
        trainLabels = Y(1:numTrain);
        testData   = X(numTrain+1:end,:);
        testLabels = Y(numTrain+1:end);
        
        initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
        initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
        initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

        addpath ../minFunc/
        options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost
                                  % function. Generally, for minFunc to work, you
                                  % need a function pointer with two outputs: the
                                  % function value and the gradient. In our problem,
                                  % sparseAutoencoderCost.m satisfies this.
        options.maxIter = 100;	  % Maximum number of iterations of L-BFGS to run 
        options.display = 'off';
        lambda=0.1;

        costFunction = @(p) nnCostFunction(p, ...
                                       input_layer_size, ...
                                       hidden_layer_size, ...
                                       num_labels, trainData, trainLabels, lambda);

        [opttheta, cost] = minFunc(costFunction,initial_nn_params, options);


        W1 = reshape(opttheta(1:hidden_layer_size * (input_layer_size + 1)), ...
                     hidden_layer_size, (input_layer_size + 1));
        W2 = reshape(opttheta((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                     num_labels, (hidden_layer_size + 1));
        pred = predict(W1, W2, testData);
        
        accuracy=mean(double(pred == testLabels))*100;
        index=strfind(fileNames{i},'_');
        str=[fileNames{i}(1:index-1) ' ' num2str(accuracy)];
        fprintf('%s\n',str);

        if maxVal<accuracy
            save(['../mymodel/' fileNames{i}(1:index-1) '_net'],'W1','W2');
            maxVal=accuracy;
        end
        
    end
end