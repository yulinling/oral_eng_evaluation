function [rv]=recallRate(pred,y,numLabels)
% rv is a vector which contains recall rate for each category
p=zeros(numLabels,1); % store the actual number of each category
rv=zeros(numLabels,1);
for i=1:numLabels
    p(i)=sum(y==i);
end

confusionMatrix=zeros(numLabels,numLabels);
m=max(size(y));
% calculate confusion matrix
for i=1:m
    confusionMatrix(pred(i),y(i))=confusionMatrix(pred(i),y(i))+1;
end

for i=1:numLabels
    rv(i)=confusionMatrix(i,i)/p(i)*100;
end