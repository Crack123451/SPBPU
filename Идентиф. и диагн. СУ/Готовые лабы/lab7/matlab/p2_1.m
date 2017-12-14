clc;
hFigure1 = figure('Color',[1 1 1]);

[X,Y] = meshgrid(10:20:90);
Z = [   9   15  16  18  27  ;
        15  24  22  33  35  ; 
        11  22  27  37  40  ; 
        16  27  36  46  52  ; 
        24  33  41  54  61];
surf(X,Y,Z)
colormap cool;
xlabel('M','FontSize',10); ylabel('R','FontSize',10); zlabel('time','FontSize',10); 
axis([0 100 0 100 0 70]);