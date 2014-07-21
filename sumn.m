function n=sumn(a,varargin)

n=0;
m=numel(varargin);

for i=1:m
    n=n+varargin{i};
end