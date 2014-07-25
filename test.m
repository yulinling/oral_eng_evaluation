function test(n,p)

for i=1:n
    prop=nchoosek(n,i)*(p^i)*(1-p)^(n-i);
    fprintf('%f\n',prop);
end