function ndata=normalize(data)

m=size(data,1);
av=mean(data);
dv=std(data);

mav=repmat(av,m,1);
mdv=repmat(dv,m,1);

ndata=(data-mav)./mdv;