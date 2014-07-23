function makeTestdataSet(path,savepath)

dirOutput=dir(path);
fileNames={dirOutput.name}';
fileNames=filterFileName(fileNames);

for i=1:length(fileNames)
    makeTestdata(savepath,[path,fileNames{i}]);
end

end