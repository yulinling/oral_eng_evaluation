function makeTestdataSet(path,savepath)

dirOutput=dir(path);
fileNames={dirOutput.name}';
fileNames=fileNames(3:end);

for i=1:length(fileNames)
    makeTestdata(savepath,[path,fileNames{i}]);
end

end