inputSize=2;
hiddenSize=421;
numLabels=5;
isSimOnDataSet=false;

data=load('data');
col=[1,2];
X=data(:,col);
%X=normalize(X);
Y=data(:,end);

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
lambda=0.8;
[Theta1,Theta2]=neuraltrain(trainData,trainLabels,inputSize,hiddenSize,...
    numLabels,lambda);
pred = predict(Theta1, Theta2, testData);
accu=100*mean(pred(:) == testLabels(:));
fixaccu=FixedAccuracy(pred,testLabels);
fprintf('Test accuracy is %f%%\n',accu);
fprintf('+1/-1 Test accuracy is %f%%\n',fixaccu);


if isSimOnDataSet==true
    total=size(X,1);
    accuracy=zeros(1,10);
    number=zeros(1,10);

    for i=1:10
        num=floor(total*i*1.0/10);
        number(i)=num;
        XX=X(1:num,:);
        YY=Y(1:num);
        numTrain = round(numel(YY)/10*7);
        trainData   = XX(1:numTrain,:);
        trainLabels = YY(1:numTrain);

        testData   = XX(numTrain+1:end,:);
        testLabels = YY(numTrain+1:end);

        % Output Some Statistics
        fprintf('-------------------Train set %d -------------------\n',i);
        fprintf('# examples in supervised training set: %d\n\n', size(trainData, 1));
        fprintf('# examples in supervised testing set: %d\n\n', size(testData, 1));

        % best param lambda=1.0
        lambda=0.8;
        [Theta1,Theta2]=neuraltrain(trainData,trainLabels,inputSize,hiddenSize,...
            numLabels,lambda);
        pred = predict(Theta1, Theta2, testData);
        accu=100*mean(pred(:) == testLabels(:));
        accuracy(i)=accu;
        fprintf('Test accuracy is %f%%\n',accu);
    end

    plot(number,accuracy,'r+-');

end
