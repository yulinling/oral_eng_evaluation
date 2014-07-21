%% load data

inputSize  = 3;  % the number of features
numLabels = 5;  % the number of class

data=load('data');
col=[1,2,3];
X=data(:,col);
Y=data(:,end);
X=normalize(X);

numTrain = round(numel(Y)/10*7);
trainData   = X(1:numTrain,:);
trainLabels = Y(1:numTrain);

% stddata=load('stddata');
% testData   = stddata(:,col);
% testLabels = stddata(:,end);

testData   = X(numTrain+1:end,:);
testLabels = Y(numTrain+1:end);

% Output Some Statistics
fprintf('# examples in supervised training set: %d\n\n', size(trainData, 1));
fprintf('# examples in supervised testing set: %d\n\n', size(testData, 1));


%% ===============part 2:  vectorlize Logistic Regression=========

lambda = 1;
[all_theta] = oneVsAll(trainData, trainLabels, numLabels, lambda);

%% ============== part 3: prediction ============================
% load('shmtestdata.mat');
pred = predictOneVsAll(all_theta, testData);
fixaccu=FixedAccuracy(pred,testLabels);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == testLabels)) * 100);
fprintf('+1/-1 Test accuracy is %f%%\n',fixaccu);