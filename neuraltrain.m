function [Theta1,Theta2]=neuraltrain(X,y,inputsize,hiddensize,num_labels,lambda)

%% Initializing parameters
initial_Theta1=randInitializeWeights(inputsize,hiddensize);
initial_Theta2=randInitializeWeights(hiddensize,num_labels);
initial_nn_params=[initial_Theta1(:); initial_Theta2(:)];

%% Trainning neural network
options=optimset('MaxIter',100);
costFunction=@(p)nnCostFunction(p,...
                                inputsize,...
                                hiddensize,...
                                num_labels,X,y,lambda);
                            
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

Theta1 = reshape(nn_params(1:hiddensize * (inputsize + 1)), ...
                 hiddensize, (inputsize + 1));

Theta2 = reshape(nn_params((1 + (hiddensize * (inputsize + 1))):end), ...
                 num_labels, (hiddensize + 1));
             
