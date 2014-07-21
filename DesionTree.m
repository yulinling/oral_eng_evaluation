function DesionTree(dataName,labelName)

inputSize  = 41;  % the number of features
numLabels = 2;  % the number of class

load(dataName);
load(labelName);

numTrain = round(numel(Y)/10*7);
trainData   = X(1:numTrain,:);
trainLabels = Y(1:numTrain);

testData   = X(numTrain+1:end,:);
testLabels = Y(numTrain+1:end);

% Output Some Statistics
fprintf('# examples in supervised training set: %d\n\n', size(trainData, 2));
fprintf('# examples in supervised testing set: %d\n\n', size(testData, 2));


%% classfication tree
tree=ClassificationTree.fit(trainData,trainLabels);
[pred score]=predict(tree,testData);
%% prediction
fprintf('Accuracy is %f\n',mean(double(pred==testLabels))*100);

end
