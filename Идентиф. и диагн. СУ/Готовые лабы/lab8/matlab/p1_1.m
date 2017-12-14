clc;
[X,Y] = meshgrid(0.1:0.2:0.9);
Z = [   30 31 31 38 43;
        30 40 39 48 52; 
        54 55 62 65 67; 
        77 77 82 82 91; 
        100 100 100 100 100];
surfc(X,Y,Z)
colormap cool;
xlabel('gamma','FontSize',10); ylabel('delta','FontSize',10); zlabel('time','FontSize',10); 
axis([0 1 0 1 0 100]);