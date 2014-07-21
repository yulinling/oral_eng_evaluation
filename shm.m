%% CS294A/CS294W Self-taught Learning Exercise

%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  self-taught learning. You will need to complete code in feedForwardAutoencoder.m
%  You will also need to have implemented sparseAutoencoderCost.m and 
%  softmaxCost.m from previous exercises.
%
%% ======================================================================
%  STEP 0: Here we provide the relevant parameters values that will
%  allow your sparse autoencoder to get good filters; you do not need to 
%  change the parameters below.

inputSize  = 200;
numLabels  = 4;
hiddenSize = 85;
sparsityParam = 0.01; % desired average activation of the hidden units.
                     % (This was denoted by the Greek alphabet rho, which looks like a lower-case "p",
		             %  in the lecture notes). default 0.3
lambda = 0.2;       % weight decay parameter: default 3e-3      
beta = 0.3;            % weight of sparsity penalty term: default 0.1  
maxIter = 400;

%% ======================================================================
%  STEP 1: Load data from the MNIST database
%
%  This loads our training and test data from the MNIST database files.
%  We have sorted the data for you in this so that you will not have to
%  change it.
unlabelSize=2000;
[UX UY]=generateTrainningData(unlabelSize,inputSize);

labelSize=1000;
[X Y]=generateTrainningData(labelSize,inputSize);
% load('trainData');

% divide labeled data into two parts: train and test
Unlabeldata=UX;

numTrain = round(numel(Y)/10*7);
trainData   = X(:,1:numTrain);
trainLabels = Y(1:numTrain);

testData   = X(:, numTrain+1:end);
testLabels = Y(numTrain+1:end);

% Output Some Statistics
fprintf('# examples in supervised training set: %d\n\n', size(trainData, 2));
fprintf('# examples in supervised testing set: %d\n\n', size(testData, 2));

%fprintf('Step 1 is finished, Press any key to continue...\n');
% pause;

%% ======================================================================
%  STEP 2: Train the sparse autoencoder
%  This trains the sparse autoencoder on the unlabeled training
%  images. 

%  Randomly initialize the parameters
theta = initializeParameters(hiddenSize, inputSize);

%% ----------------- YOUR CODE HERE ----------------------
%  Find opttheta by running the sparse autoencoder on
%  unlabeledTrainingImages

opttheta = theta; 

addpath minFunc/
options.Method = 'lbfgs'; % Here, we use L-BFGS to optimize our cost
                          % function. Generally, for minFunc to work, you
                          % need a function pointer with two outputs: the
                          % function value and the gradient. In our problem,
                          % sparseAutoencoderCost.m satisfies this.
options.maxIter = 400;	  % Maximum number of iterations of L-BFGS to run 
options.display = 'on';

% sparsityParam = [0.001 0.003 0.01 0.03 0.10 0.3 1.0 3.0];
% lambda = [0.001 0.003 0.01 0.03 0.1 0.3 1.0 3.0];
% beta = [0.001 0.003 0.01 0.03 0.1 0.3 1.0 3.0];
% trainError=[];
% testError=[];
% index=[];
% accuracy=[];
% for i=1:length(sparsityParam)
%     for j=1:length(lambda)
%         for k=1:length(beta)
%         [opttheta, cost] = minFunc( @(p) sparseAutoencoderCost(p, ...
%                                            inputSize, hiddenSize, ...
%                                            lambda(j), sparsityParam(i), ...
%                                            beta(k), Unlabeldata), ...
%                                       theta, options);
%          trainTemp=sparseAutoencoderCost(opttheta,inputSize,hiddenSize,...
%                                 lambda(j),sparsityParam(i),beta(k),trainData);
%          testTemp=sparseAutoencoderCost(opttheta,inputSize,hiddenSize,...
%                                 lambda(j),sparsityParam(i),beta(k),testData);
%          trainError=[trainError trainTemp];
%          testError=[testError testTemp];
%          index=[index;i j k];
%          trainFeatures = feedForwardAutoencoder(opttheta, hiddenSize, inputSize, ...
%                                        trainData);
% 
%          testFeatures = feedForwardAutoencoder(opttheta, hiddenSize, inputSize, ...
%                                        testData);
%          inputsz=hiddenSize;
%          hiddensz=22;
%          lambda2=0.1;
%          [Theta1,Theta2]=neuraltrain(trainFeatures',trainLabels,inputsz,hiddensz,...
%             numLabels,lambda2);
%          pred = predict(Theta1, Theta2, testFeatures');
%          accuracy=[accuracy 100*mean(pred(:) == testLabels(:))];
%         end
%     end
% end
% 
% for i=1:length(trainError)
%     fprintf('index: %d %d %d\n',index(i,1),index(i,2),index(i,3));
%     fprintf('train error is: %f\n',trainError(i));
%     fprintf('train error is: %f\n',testError(i));
%     fprintf('test accuracy is %f%%\n',accuracy(i));
%     fprintf('\n');
% end

% % current optima param (index: 6 4 7)
% % sparsityParam=0.3;
% % lambda=0.03;
% % beta=1;

sparsityParam=0.010;
lambda=0.003;
beta=0.1;
[opttheta, cost] = minFunc( @(p) sparseAutoencoderCost(p, ...
                                   inputSize, hiddenSize, ...
                                   lambda, sparsityParam, ...
                                   beta, trainData), ...
                              theta, options);

% display hidden layer
W1 = reshape(opttheta(1:hiddenSize * inputSize), hiddenSize, inputSize);
displayHiddenLayer(W1');

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
fprintf('Test accuracy is %f%%\n',100*mean(pred(:) == testLabels(:)));


% sparsityParam choose 0.3
% select parameter lambda
% sparsityParam=0.3;
% lambda=[0.001 0.003 0.010 0.03 0.10 0.3 1 3 10 30];
% trainError=[];
% testError=[];
% for i=1:10
%     [opttheta, cost] = minFunc( @(p) sparseAutoencoderCost(p, ...
%                                        inputSize, hiddenSize, ...
%                                        lambda(i), sparsityParam, ...
%                                        beta, trainData), ...
%                                   theta, options);
%      trainTemp=sparseAutoencoderCost(opttheta,inputSize,hiddenSize,...
%                                 lambda(i),sparsityParam,beta,trainData);
%      testTemp=sparseAutoencoderCost(opttheta,inputSize,hiddenSize,...
%                                 lambda(i),sparsityParam,beta,testData);
%      trainError=[trainError trainTemp];
%      testError=[testError testTemp];
% end
% for i=1:10
%     fprintf('train error is: %f\n',trainError(i));
%     fprintf('test error is: %f\n',testError(i));
%     fprintf('\n');
% end
% plot(lambda,trainError,'r*-');
% hold on;
% plot(lambda,testError,'b*-');
% hold off;

% sparsityParam choose 0.3
% lambda choose 0.003
% select parameter beta 1
% sparsityParam=0.3;
% lambda=0.003;
% beta=[0.001 0.003 0.010 0.03 0.10 0.3 1 3 10 30];
% trainError=[];
% testError=[];
% for i=1:10
%     [opttheta, cost] = minFunc( @(p) sparseAutoencoderCost(p, ...
%                                        inputSize, hiddenSize, ...
%                                        lambda, sparsityParam, ...
%                                        beta(i), Unlabeldata), ...
%                                   theta, options);
%      trainTemp=sparseAutoencoderCost(opttheta,inputSize,hiddenSize,...
%                                 lambda,sparsityParam,beta(i),Unlabeldata);
%      testTemp=sparseAutoencoderCost(opttheta,inputSize,hiddenSize,...
%                                 lambda,sparsityParam,beta(i),Unlabeldata);
%      trainError=[trainError trainTemp];
%      testError=[testError testTemp];
% end
% for i=1:10
%     fprintf('train error is: %f\n',trainError(i));
%     fprintf('test error is: %f\n',testError(i));
%     fprintf('\n');
% end
% plot(beta,trainError,'r*-');
% hold on;
% plot(beta,testError,'b*-');
% hold off;

%======================================================================
%% STEP 3: Extract Features from the Supervised Dataset
%  
%  You need to complete the code in feedForwardAutoencoder.m so that the 
%  following command will extract features from the data.

% trainFeatures = feedForwardAutoencoder(opttheta, hiddenSize, inputSize, ...
%                                        trainData);
% 
% testFeatures = feedForwardAutoencoder(opttheta, hiddenSize, inputSize, ...
%                                        testData);

%======================================================================
%% STEP 4: Train the softmax classifier


%% ----------------- YOUR CODE HERE ----------------------
%  Use softmaxTrain.m from the previous exercise to train a multi-class
%  classifier. 

%  Use lambda = 1e-4 for the weight regularization for softmax

% You need to compute softmaxModel using softmaxTrain on trainFeatures and
% trainLabels
% lambda = 1e-4;
% softmaxModel = struct;  
% softmaxModel=softmaxTrain(hiddenSize, numLabels, lambda, trainFeatures, ...
%     trainLabels, options);
% inputsz=hiddenSize; % which is 36
% hiddensz=22;
% lambda=[0.001,0.003,0.01,0.03,0.1,0.3,1,3];
% accuracy=[];
% for i=1:length(lambda)
%     [Theta1,Theta2]=neuraltrain(trainFeatures',trainLabels,inputsz,hiddensz,...
%         numLabels,lambda(i));
%     pred = predict(Theta1, Theta2, testFeatures');
%     accuracy=[accuracy 100*mean(pred(:) == testLabels(:))];
% end 
% 
% for i=1:length(accuracy)
%     fprintf('no%d accuracy is %f\n',i,accuracy(i));
% end

