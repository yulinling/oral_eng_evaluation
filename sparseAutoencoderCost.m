function [cost,grad] = sparseAutoencoderCost(theta, visibleSize, hiddenSize, ...
                                             lambda, sparsityParam, beta, data)
%% INFORMATION
% sparse autoencoder : Vectorization version
% visibleSize: the number of input units (probably 64) 
% hiddenSize: the number of hidden units (probably 25) 
% lambda: weight decay parameter
% sparsityParam: The desired average activation for the hidden units (denoted in the lecture
%                           notes by the greek alphabet rho, which looks like a lower-case "p").
% beta: weight of sparsity penalty term
% data: Our 64x10000 matrix containing the training data.  So, data(:,i) is the i-th training example. 

% -------------------------------------------------------------------------%
% implemented by xie xiaobo at 2013/7/13
% -------------------------------------------------------------------------%

%% part I
W1=reshape(theta(1:hiddenSize*visibleSize),hiddenSize,visibleSize);
W2=reshape(theta(hiddenSize*visibleSize+1:2*hiddenSize*visibleSize),visibleSize,hiddenSize);
b1=theta(2*hiddenSize*visibleSize+1:2*hiddenSize*visibleSize+hiddenSize);
b2=theta(2*hiddenSize*visibleSize+hiddenSize+1:end);

cost = 0;
W1grad = zeros(size(W1)); 
W2grad = zeros(size(W2));
b1grad = zeros(size(b1)); 
b2grad = zeros(size(b2));
m=size(data,2);
%% part II: first pass, compute the average activation of hidden unit

a1=data;
z2=W1*a1+repmat(b1,1,m);
a2=sigmoid(z2);
z3=W2*a2+repmat(b2,1,m);
a3=sigmoid(z3);
rho=sum(a2,2)./m;
cost=sum(sum((a3-a1).^2/2))/m;
weight_decay=lambda*(sum(sum(W1.^2))+sum(sum(W2.^2)))/2;
sparse_term=beta*sum(sparsityParam.*log(sparsityParam./rho)+(1-sparsityParam).*log((1-sparsityParam)./(1-rho)));
cost=cost+weight_decay+sparse_term;

%% part III: second pass: compute the partial derivatives of weights and bias
a1=data;
z2=W1*a1+repmat(b1,1,m);
a2=sigmoid(z2);
z3=W2*a2+repmat(b2,1,m);
a3=sigmoid(z3);
delta3=(a3-a1).*a3.*(1-a3);
delta2=(W2'*delta3+repmat(beta.*(-sparsityParam./rho+(1-sparsityParam)./(1-rho)),1,m)).*a2.*(1-a2);
W2grad=(a2*delta3')'/m+lambda.*W2;
W1grad=(a1*delta2')'/m+lambda.*W1;
b2grad=sum(delta3,2)/m;
b1grad=sum(delta2,2)/m;

grad = [W1grad(:) ; W2grad(:) ; b1grad(:) ; b2grad(:)];

end

function sigm = sigmoid(x)
    sigm = 1 ./ (1 + exp(-x));
end
