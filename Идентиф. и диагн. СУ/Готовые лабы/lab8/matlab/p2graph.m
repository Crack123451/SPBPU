clear, close, clc 
M =   [10    30    50    70    90];
R =   [10    30    50    70    90];
P_M = [0.04  0.025  0.015 0.01 0.004];
P_R = [0.03  0.022  0.015 0.01 0.005];
p1 = polyfit(M,P_M,2);
p2 = polyfit(R,P_R,2);

hFigure1 = figure('Color',[1 1 1]);
hAxes1 = axes('Visible','on','Parent',hFigure1);
box('on');
hold('all');
grid on; 
xlabel( hAxes1, 'R','FontSize',10); ylabel(hAxes1, 'Вероятность ЛО','FontSize',10);   
fplot(@(R)polyval(p2,R), [0 100], 'g');
plot(R,P_R,'*');
% xlim([0 1]); 