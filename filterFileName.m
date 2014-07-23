function names=filterFileName(fileNames)
names={};
for i=1:length(fileNames)
    if fileNames{i}(1:1)=='.'
        continue;
    else
        names=[names fileNames{i}];
    end
end

end