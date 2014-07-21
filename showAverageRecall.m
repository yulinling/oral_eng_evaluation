spr=reshape(sparse_recall,4,10);
spr=mean(spr);
nnr=reshape(nn_recall,4,10);
nnr=mean(nnr);
svmr=reshape(svm_recall,4,10);
svmr=mean(svmr);
lgr=reshape(lg_recall,4,10);
lgr=mean(lgr);
softr=reshape(softmax_recall,4,10);
softr=mean(softr);
dtr=reshape(dtree_recall,4,10);
dtr=mean(dtr);
fprintf('sparse coding average recall:\n');
spr
fprintf('neural network average recall:\n');
nnr
fprintf('svm average recall:\n');
svmr
fprintf('logistic regression average recall:\n');
lgr
fprintf('softmax regression average recall:\n');
softr
fprintf('decision tree average recall:\n');
dtr
