clc;
q=0.95;
N_exp = 5;
T_array = [73 75 80 70 74];
T_int(1,1) = mean(T_array) - tinv( (1+q)/2, N_exp-1 ) * std(T_array) / sqrt(N_exp);
T_int(1,2) = mean(T_array) + tinv( (1+q)/2, N_exp-1 ) * std(T_array) / sqrt(N_exp); 

mean(T_array)
T_int

hFigure1 = figure('Color',[1 1 1]);
hAxes1 = axes('Visible','on','Parent',hFigure1);
box('on');
hold('all');
grid on; 
xlabel( hAxes1, 'Tобн','FontSize',10); ylabel(hAxes1, '','FontSize',10); 
ylim([0 4]);

x1=[43.1 54.8]; 
y1(1:2)=1;
plot(x1,y1,'-*','color','blue');plot(49,1,'o');


x2=[64.8 83.9]; 
y2(1:2)=2;
plot(x2,y2,'-*','color','red');plot(74.4,2,'o');

x3=[91 120.5]; 
y3(1:2)=3;
plot(x3,y3,'-*','color','black');plot(105.8,3,'o');



