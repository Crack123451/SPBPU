clc;
q=0.95;
N_exp = 5;
T_array = [34 34 33 45 34];
T_int(1,1) = mean(T_array) - tinv( (1+q)/2, N_exp-1 ) * std(T_array) / sqrt(N_exp);
T_int(1,2) = mean(T_array) + tinv( (1+q)/2, N_exp-1 ) * std(T_array) / sqrt(N_exp); 

mean(T_array)
T_int

hFigure1 = figure('Color',[1 1 1]);
hAxes1 = axes('Visible','on','Parent',hFigure1);
box('on');
hold('all');
grid on; 
xlabel( hAxes1, 'T���','FontSize',10); ylabel(hAxes1, '','FontSize',10); 
ylim([0 4]);

x1=[76.7 100.8]; 
y1(1:2)=3;
plot(x1,y1,'-*','color','blue');plot(88.8,'o');


x2=[47.4 66.1]; 
y2(1:2)=2;
plot(x2,y2,'-*','color','red');plot(56.8,2,'o');

x2=[29.7 42.2]; 
y2(1:2)=1;
plot(x2,y2,'-*','color','black');plot(36,1,'o');



