function sdata=scaleData(data)

m=size(data,1);
minVal=min(data);
maxVal=max(data);

minVal=repmat(minVal,m,1);
maxVal=repmat(maxVal,m,1);

sdata=(data-minVal)./(maxVal-minVal);