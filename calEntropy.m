function entropy=calEntropy(data)

label=data(:,end:end);
n=length(label);
labelCnt=zeros(1,5);
for i=1:n
    labelCnt(label(i))=labelCnt(label(i))+1;
end

entropy=0;
for i=1:5
    prob=labelCnt(i)*1.0/n;
    entropy=entropy+(-1.0)*prob*log(prob);
end

end