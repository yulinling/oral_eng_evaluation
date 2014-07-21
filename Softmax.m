inputSize  = 41;  % the number of features
numLabels = 2;  % the number of class

%% ===============part 1:  load data=============================
load('ae_ay.mat');

numTrain = round(numel(Y)/10*7);
trainData   = X(1:numTrain,:);
trainLabels = Y(1:numTrain);

testData   = X(numTrain+1:end,:);
testLabels = Y(numTrain+1:end);

% Output Some Statistics
fprintf('# examples in supervised training set: %d\n\n', size(trainData, 1));
fprintf('# examples in supervised testing set: %d\n\n', size(testData, 1));

%% train 
% lambda=0.0003;
lambda=1;
softmaxModel = softmaxTrain(inputSize, numLabels, lambda, trainData, trainLabels);
pred = softmaxPredict(softmaxModel, testData);

fprintf('Test accuracy is %f%%\n',mean(double(pred == testLabels)) * 100);