%% support vector machine

%% part 1: load data
inputSize  = 41;
numLabels  = 2;

load('ae_ay.mat');

numTrain = round(numel(Y)/10*7);
trainData   = X(1:numTrain,:);
trainLabels = Y(1:numTrain);

testData   = X(numTrain+1:end,:);
testLabels = Y(numTrain+1:end);

fprintf('# examples in supervised training set: %d\n\n', size(trainData, 1));
fprintf('# examples in supervised testing set: %d\n\n', size(testData, 1));
% 
% %% part 3: 5-fold cross validation and grid search parameters
% % split training data into 5 parts
% numParts=round(numel(trainLabels)/5);
% data=cell(2,5);
% for i=1:5
%     data{i,1}=trainData(:,(i-1)*numParts+1:i*numParts);
%     data{i,2}=trainLabels((i-1)*numParts+1:i*numParts);
% end
% 
% % 5-fold cross validation
% c=[2^-4 2^-3 2^-2 2^-1 1 2 4 8 32 64];
% gama=[2^-4 2^-3 2^-2 2^-1 1 2 4 8];
% index=[];
% maxAccuracy=0;
% opt_c=0;
% opt_gama=0;
% for p=1:length(c)
%     for q=1:length(gama)
%         accuracy=[];
%         option=['-t 2 -c ',num2str(c(p)),' -g ',num2str(gama(q))];
%         for i=1:5
%             % reconstruct training data and test data
%             t_testData=data{i,1};
%             t_testLabels=data{i,2};
%             t_trainData=[];
%             t_trainLabels=[];
%             for j=1:5
%                 if j~=i
%                     t_trainData=[t_trainData data{j,1}];
%                     t_trainLabels=[t_trainLabels;data{j,2}];
%                 end
%             end
%             model=svmtrain(t_trainLabels,t_trainData',option);
%             [pred,accu,dec_values]=svmpredict(t_testLabels,t_testData',model);
%             accuracy=[accuracy accu(1)];
%         end
%         fprintf('iteration(%d,%d): c=%f gama=%f\n',p,q,c(p),gama(q));
%         fprintf('5-fold average cross-validation rate is %f%%\n',mean(accuracy));
%         if(mean(accuracy)>maxAccuracy)
%             maxAccuracy=mean(accuracy);
%             opt_c=c(p);
%             opt_gama=gama(q); 
%         end
%     end
% end
% fprintf('finding optimal parameter: c=%f, gama=%f\n',opt_c,opt_gama);
% fprintf('conresponding cross-validation rate is %f%%\n',maxAccuracy);

%% part 4: train with whole trainning data with optimal parameters
% option -c 10 -g 0.028
model=svmtrain(trainData,trainLabels);
[pred,accu]=svmpredict(testLabels,testData,model);
fprintf('Test accuracy is %f%%\n',accu(1));
