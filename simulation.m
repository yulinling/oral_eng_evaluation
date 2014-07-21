%% part 1: training
num_examples=[50,100,200,300,400,500,600,700,800,1000];
inputSize  = 200;
numLabels  = 4;
sparse_accuracy=[];
nn_accuracy=[];
svm_accuracy=[];
lg_accuracy=[];
dtree_accuracy=[];
softmax_accuracy=[];
sparse_recall=[];
nn_recall=[];
svm_recall=[];
lg_recall=[];
dtree_recall=[];
softmax_recall=[];

hasNoise=true; % default: false
isdraw=true; % default: true;

for i=1:length(num_examples)
    % generate data
    unlabelSize=2000;
    if hasNoise==false
        [UX UY]=generateTrainningData(unlabelSize,inputSize);
        Unlabeldata=UX;
        labelSize=num_examples(i);
        [X Y]=generateTrainningData(labelSize,inputSize);
    else
        [UX UY]=generateTrainningData2(unlabelSize,inputSize);
        Unlabeldata=UX;
        labelSize=num_examples(i);
        [X Y]=generateTrainningData2(labelSize,inputSize);
    end
    % split data into two parts: training and testing
    numTrain = round(numel(Y)/10*7);
    trainData   = X(:,1:numTrain);
    trainLabels = Y(1:numTrain);
    testData   = X(:, numTrain+1:end);
    testLabels = Y(numTrain+1:end);
    
    % neural network with sparse autoencoder
    hiddenSize = 85;
    sparsityParam = 0.01; % desired average activation of the hidden units.
                     % (This was denoted by the Greek alphabet rho, which looks like a lower-case "p",
		             %  in the lecture notes). default 0.3
    lambda = 0.003;       % weight decay parameter: default 3e-3      
    beta = 0.1;            % weight of sparsity penalty term: default 0.1  
    maxIter = 400;
    theta = initializeParameters(hiddenSize, inputSize);
    opttheta = theta; 
    addpath minFunc/
    options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost
                              % function. Generally, for minFunc to work, you
                              % need a function pointer with two outputs: the
                              % function value and the gradient. In our problem,
                              % sparseAutoencoderCost.m satisfies this.
    options.maxIter = 400;	  % Maximum number of iterations of L-BFGS to run 
    options.display = 'on';
    [opttheta, cost] = minFunc( @(p) sparseAutoencoderCost(p, ...
                                   inputSize, hiddenSize, ...
                                   lambda, sparsityParam, ...
                                   beta, trainData), ...
                              theta, options);
    trainFeatures = feedForwardAutoencoder(opttheta, hiddenSize, inputSize, ...
                                           trainData);

    testFeatures = feedForwardAutoencoder(opttheta, hiddenSize, inputSize, ...
                                           testData);
    inputsz=hiddenSize;
    hiddensz=26;
    lambda2=1;
    [Theta1,Theta2]=neuraltrain(trainFeatures',trainLabels,inputsz,hiddensz,...
    numLabels,lambda2);
    pred = predict(Theta1, Theta2, testFeatures');
    sparse_accuracy=[sparse_accuracy 100*mean(pred(:) == testLabels(:))];
    rv=recallRate(pred,testLabels,numLabels);
    sparse_recall=[sparse_recall;rv];
    
    % neural network without sparse autoencoder
    lambda2=10;
    [Theta1,Theta2]=neuraltrain(trainData',trainLabels,inputSize,hiddenSize,...
        numLabels,lambda2);
    pred = predict(Theta1, Theta2, testData');
    nn_accuracy=[nn_accuracy 100*mean(pred(:) == testLabels(:))];
    rv=recallRate(pred,testLabels,numLabels);
    nn_recall=[nn_recall;rv];
    
    % SVM
    model=svmtrain(trainLabels,trainData','-c 10 -g 0.028');
    [pred,accu,dec_values]=svmpredict(testLabels,testData',model);
    svm_accuracy=[svm_accuracy 100*mean(pred(:) == testLabels(:))];
    rv=recallRate(pred,testLabels,numLabels);
    svm_recall=[svm_recall;rv];
    
    % logistic regression
    lambda = 0.1;
    [all_theta] = oneVsAll(trainData', trainLabels, numLabels, lambda);
    pred = predictOneVsAll(all_theta, testData');
    lg_accuracy=[lg_accuracy 100*mean(pred(:) == testLabels(:))];
    rv=recallRate(pred,testLabels,numLabels);
    lg_recall=[lg_recall;rv];
    
    % softmax regression
    lambda=0.0003;
    softmaxModel = softmaxTrain(inputSize, numLabels, lambda, trainData, trainLabels);
    pred = softmaxPredict(softmaxModel, testData);
    softmax_accuracy=[softmax_accuracy 100*mean(pred(:) == testLabels(:))];
    rv=recallRate(pred,testLabels,numLabels);
    softmax_recall=[softmax_recall;rv];
    
    % decision tree
    tree=ClassificationTree.fit(trainData',trainLabels);
    [pred score]=predict(tree,testData');
    dtree_accuracy=[dtree_accuracy 100*mean(pred(:) == testLabels(:))];
    rv=recallRate(pred,testLabels,numLabels);
    dtree_recall=[dtree_recall;rv];
end

%% part 2: drawing
if isdraw==true;
    % plot test accuracy
    figure;
    plot(num_examples,sparse_accuracy,'k-*','MarkerSize',8);
    hold on;
    plot(num_examples,nn_accuracy,'k-h','MarkerSize',8);
    plot(num_examples,svm_accuracy,'k-s','MarkerSize',8);
    plot(num_examples,lg_accuracy,'k-d','MarkerSize',8);
    plot(num_examples,softmax_accuracy,'k-x','MarkerSize',8);
    plot(num_examples,dtree_accuracy,'k-+','MarkerSize',8);
    hold off;
    title('Classification Accuracy');
    xlabel('Trainning set size'), ylabel('Accuracy(%)');
    legend('Sparse coding','Neural network','SVM','Logistic regression',...
        'Softmax regression','Decision tree','Location','SouthEast');
    if hasNoise==false
        fileName='accuracy.mat';
    else
        fileName='accuracyWithNoise.mat';
    end
    save(fileName,'sparse_accuracy','nn_accuracy','svm_accuracy','lg_accuracy',...
        'softmax_accuracy','dtree_accuracy');

    % save recall rate
    save('recallRate.mat','sparse_recall','nn_recall','svm_recall','lg_recall',...
        'softmax_recall','dtree_recall');
    
    % plot orignal data
    n=size(X,2);
    index=randperm(n);
    index=index(1:4);
    figure;
    for i=1:4
        subplot(4,1,i),plot(X(:,index(i)));
    end
end


