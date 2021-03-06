clear, close, clc 
x =     [0.1   0.2   0.3   0.4   0.5   0.6   0.7   0.8   0.9   ];
delta = [0.04  0.03  0.02  0.013 0.006 0.007 0.003 0.0032 0.002 ];
gamma = [0.017 0.017 0.014 0.013 0.006 0.005 0.005 0.0032 0.004 ];
m_x     = [10  30   50   70    90    100];
M       = [0.1 0.08 0.05 0.03  0.02  0.01];
p2 = polyfit(x,delta,3)
p1 = polyfit(x,gamma,2)
p3 = polyfit(m_x,M,3)
hFigure1 = figure('Color',[1 1 1]);
hAxes1 = axes('Visible','on','Parent',hFigure1);
box('on');
hold('all');
grid on; 
xlabel( hAxes1, '������ �����, �','FontSize',10); ylabel(hAxes1, '����������� ��','FontSize',10);   
fplot(@(m_x)polyval(p3,m_x), [0 100], 'g');
plot(m_x,M,'*');
% xlim([0 1]); 