function fixAccu=FixedAccuracy(pred,label)

n=size(pred,1);
hit=0;
for i=1:n
    if abs(pred(i)-label(i))<=1
        hit=hit+1;
    end
end

fixAccu=double(hit)/n*100;