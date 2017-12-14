T = [0:t:Tf];
% Cистема
figure('color', 'white');
sys=ss(A,B,C,D);
[Y,T] = step(sys,T);


step(sys,T);
grid on


% Устройство детектирования
I = lab5_3(Y,t,Tf,a00d,a01d,a10d,a11d,b0d,b1d);
figure('color', 'white');
fig2 = plot(T,I);
grid on
xlabel('T');
ylabel('MY+Z');
% set(gca,'YLim',[-0.0007 0.0006]);
grid on