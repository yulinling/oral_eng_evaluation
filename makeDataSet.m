function makeDataSet(path,savepath)

% 元音数据
makeData(savepath,[path,'aa'],[path,'ah'],45,[path,'ay'],34,[path,'ae'],29);
makeData(savepath,[path,'ae'],[path,'ay'],82,[path,'eh'],35,[path,'aa'],29);
makeData(savepath,[path,'ah'],[path,'eh'],56,[path,'aa'],69,[path,'ae'],21);
makeData(savepath,[path,'ao'],[path,'ow'],70,[path,'aa'],51,[path,'aw'],43);
makeData(savepath,[path,'aw'],[path,'ao'],38,[path,'ow'],33);
makeData(savepath,[path,'ax'],[path,'ao'],100,[path,'eh'],89,[path,'ey'],78);
makeData(savepath,[path,'ay'],[path,'eh'],110,[path,'ae'],160,[path,'ey'],59,[path,'ih'],29,[path,'aa'],21);
makeData(savepath,[path,'eh'],[path,'ih'],170,[path,'ey'],142,[path,'ae'],68,[path,'aa'],33,[path,'ay'],120);
makeData(savepath,[path,'er'],[path,'aa'],31,[path,'ah'],31,[path,'ao'],31);
makeData(savepath,[path,'ey'],[path,'eh'],170,[path,'ay'],49,[path,'iy'],28);
makeData(savepath,[path,'ih'],[path,'iy'],61,[path,'ey'],55,[path,'ay'],31,[path,'eh'],32);
makeData(savepath,[path,'iy'],[path,'ey'],55,[path,'ih'],45,[path,'eh'],33);
makeData(savepath,[path,'ow'],[path,'aw'],120,[path,'uw'],21);
makeData(savepath,[path,'oy'],[path,'ao'],34,[path,'aw'],15);
makeData(savepath,[path,'uh'],[path,'uw'],32,[path,'ow'],15);
makeData(savepath,[path,'uw'],[path,'uh'],32);

%辅音数据
makeData(savepath,[path,'b'],[path,'p'],59);
makeData(savepath,[path,'d'],[path,'t'],37);
makeData(savepath,[path,'f'],[path,'v'],32);
makeData(savepath,[path,'g'],[path,'k'],38);
makeData(savepath,[path,'k'],[path,'g'],38);
makeData(savepath,[path,'l'],[path,'r'],268,[path,'n'],85);
makeData(savepath,[path,'m'],[path,'n'],16);
makeData(savepath,[path,'n'],[path,'l'],114);
makeData(savepath,[path,'p'],[path,'b'],120);
makeData(savepath,[path,'r'],[path,'l'],102);
makeData(savepath,[path,'s'],[path,'sh'],40,[path,'dh'],32,[path,'z'],17);
makeData(savepath,[path,'t'],[path,'d'],33);
makeData(savepath,[path,'v'],[path,'w'],606,[path,'f'],100);
makeData(savepath,[path,'w'],[path,'v'],421);
makeData(savepath,[path,'y'],[path,'s'],33);
makeData(savepath,[path,'z'],[path,'s'],32,[path,'dh'],32,[path,'th'],21);
makeData(savepath,[path,'ch'],[path,'jh'],32,[path,'sh'],32);
makeData(savepath,[path,'dh'],[path,'z'],120,[path,'s'],100);
makeData(savepath,[path,'hh'],[path,'g'],32,[path,'k'],32);
makeData(savepath,[path,'jh'],[path,'s'],32,[path,'sh'],32,[path,'ch'],21);
makeData(savepath,[path,'ng'],[path,'n'],32);
makeData(savepath,[path,'sh'],[path,'s'],45);
makeData(savepath,[path,'th'],[path,'z'],1152,[path,'s'],1125,[path,'d'],114,[path,'l'],83);
makeData(savepath,[path,'zh'],[path,'sh'],32,[path,'s'],32);
% add sil
makeTestdata(savepath,[path,'sil']);

