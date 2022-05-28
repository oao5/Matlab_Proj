
h=figure('units','normalized','position',[0,0,1,1]);
set(h)
set(h,'MenuBar','none','WindowState','fullscreen','toolbar','none')
set(h,'color','white')
xrp=rand(1,16);
yrp=rand(1,16);
XX=text(yrp,xrp,"X",'color','red');
axis off;
g=text(0.5,0.5,"X",'color','red')
tic
pause;key = get(h,'CurrentCharacter')
acc=strcmpi('x',key)
toc