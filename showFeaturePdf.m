function showFeaturePdf(data)

X=data(:,1);
Y=data(:,2);
Z=data(:,3);
label=data(:,4);

color=['r';'g';'b';'c';'m'];
X=scaleData(X);
x=-1:0.01:3;
y=normpdf(x,mean(X),std(X));
figure;
plot(x,y,'k');
for i=1:5
    index=find(label==i);
    y=normpdf(x,mean(X(index)),std(X(index)));
    hold on;
    plot(x,y,color(i));
end
hold off;
legend('all_cate','cate_1','cate_2','cate_3','cate_4','cate_5');
title('Feature:RankScore');

Y=scaleData(Y);
y=normpdf(x,mean(Y),std(Y));
figure;
plot(x,y,'k');
for i=1:5
    index=find(label==i);
    y=normpdf(x,mean(Y(index)),std(Y(index)));
    hold on;
    plot(x,y,color(i));
end
hold off;
legend('all_cate','cate_1','cate_2','cate_3','cate_4','cate_5');
title('Feature:SegDurationScore');

Z=scaleData(Z);
y=normpdf(x,mean(Z),std(Z));
figure;
plot(x,y,'k');
for i=1:5
    index=find(label==i);
    y=normpdf(x,mean(Z(index)),std(Z(index)));
    hold on;
    plot(x,y,color(i));
end
hold off;
legend('all_cate','cate_1','cate_2','cate_3','cate_4','cate_5');
title('GopScore');