function NeuralNetwork_2(dataName,labelName);

inputSize=41;
hiddenSize=10;
numLabels=2;

load(dataName);
load(labelName);

numTrain = round(numel(Y)/10*7);
trainData   = X(1:numTrain,:);
trainLabels = Y(1:numTrain);

% stddata=load('stddata');
% testData   = stddata(:,col);
% testLabels = stddata(:,end);

testData   = X(numTrain+1:end,:);
testLabels = Y(numTrain+1:end);

% Output Some Statistics
fprintf('-------------------Train set %d -------------------\n',i);
fprintf('# examples in supervised training set: %d\n\n', size(trainData, 1));
fprintf('# examples in supervised testing set: %d\n\n', size(testData, 1));

% best param lambda=1.0
lambda=1.0;
[Theta1,Theta2]=neuraltrain(trainData,trainLabels,inputSize,hiddenSize,...
    numLabels,lambda);
pred = predict(Theta1, Theta2, testData);
accu=100*mean(pred(:) == testLabels(:));
fprintf('Test accuracy is %f%%\n',accu);

