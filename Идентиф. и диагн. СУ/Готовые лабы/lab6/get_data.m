function get_data(filename)
clc;
fin=fopen(filename);
if (fin == -1)
    disp('file not open');
end

data=textscan(fin,'%f %f %f %f','headerLines',3);
%disp(time);
time =  data{1,1};
X =     data{1,2};
DX =    data{1,3};
U =    data{1,4};
% 
% 
% while i <= size(time,1)
%     d1 = d1 + (data{1,6}(i)^2);
%     d2 = d2 + (data{1,7}(i)^2);
%     i=i+1;
% end

hFigure1 = figure('Color',[1 1 1]);
hAxes1 = axes('Visible','on','Parent',hFigure1);
box('on');
hold('all');
grid on; 
xlabel( hAxes1, 'Time, c','FontSize',10); ylabel(hAxes1, 'U, X','FontSize',10);   

plot(time, X,time , DX);
stairs(time, U);
legend('Канал 1', 'Канал 2','Управление');

 xlim([0 10]);
% disp (d1/d2);
fclose(fin);
end