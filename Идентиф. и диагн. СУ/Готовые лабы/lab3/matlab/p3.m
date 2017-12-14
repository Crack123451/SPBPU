clear all
clc
count = 1000;   % число измерений
M = 0;          % новое значение МО
D = 4;          % новое значение Д
Dfm = 500;     % момент возникновения неисправности
 
T=1:count;      
 
for i=1:count
    if (i < Dfm)
        base1(i) = normrnd(0,1);
        base2(i) = normrnd(0,1);
        base3(i) = normrnd(0,1);
    else
        base1(i) = normrnd(M,D);
        base2(i) = normrnd(0,1);
        base3(i) = normrnd(0,1);
    end
    % Инвариант среднее арифметическое
    delta1(i) = base1(i) - median([base1(i) base2(i) base3(i)]);
    delta2(i) = base2(i) - median([base1(i) base2(i) base3(i)]);
    delta3(i) = base3(i) - median([base1(i) base2(i) base3(i)]);
    
    % Оценка инварианта
    mu1(i) = mean(delta1);
    mu2(i) = mean(delta2);
    mu3(i) = mean(delta3);
    d1(i) = std(delta1);
    d2(i) = std(delta2);
    d3(i) = std(delta3);
end

figure('color', 'white');

subplot(3,1,1);
plot(T,base1,'k');
ylabel('Y1');
grid on

subplot(3,1,2);
plot(T,base2,'b');
ylabel('Y2');
grid on

subplot(3,1,3);
plot(T,base3,'r');
xlabel('t');
ylabel('Y3');
grid on

figure('color', 'white')
% Оценка МО
subplot(2,1,1);
plot(T,mu1,'k',T,mu2,'b',T,mu3,'r');
ylabel('M');
grid on
% Оценка Д
subplot(2,1,2);
plot(T,d1,'k',T,d2,'b',T,d3,'r');
xlabel('t');
ylabel('D');
grid on
