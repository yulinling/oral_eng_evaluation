function calInfoGain(data)

totalEntropy=calEntropy(data);
fprintf('total entropy: %f\n',totalEntropy);
featureEntropy=zeros(1,size(data,2)-1);

for i=1:size(data,2)-1
    subDataset=cell(1,4);
    X=data(:,i);
    stdvar=std(X);
    avg=mean(X);
    for j=1:length(X)
        if X(j)<avg-stdvar
            subDataset{1}=[subDataset{1};data(j,:)];
        elseif X(j)>=avg-stdvar&&X(j)<avg
            subDataset{2}=[subDataset{2};data(j,:)];
        elseif X(j)>=avg&&X(j)<avg+stdvar
            subDataset{3}=[subDataset{3};data(j,:)];
        else
            subDataset{4}=[subDataset{4};data(j,:)];
        end
    end
    
    entropy=0;
    for k=1:4
        h=calEntropy(subDataset{k});
        entropy=entropy+length(subDataset{k})*h*1.0/length(X);
    end
    
    featureEntropy(i)=entropy;
end

for i=1:length(featureEntropy)
    fprintf('Feature %d Information Gain: %f\n',i,totalEntropy-featureEntropy(i));
    fprintf('Feature %d Information Gain rate: %f%%\n',i,(totalEntropy-featureEntropy(i))*100/totalEntropy);
end

end