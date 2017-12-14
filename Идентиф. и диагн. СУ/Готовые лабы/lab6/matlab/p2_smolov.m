clc, clear all, echo off
 
M = 40;       %глубина памяти алгоритма
R = 40;       %глубина памяти обновляющей матрицы
summl=zeros(1,M);
 
Plo = 0;     %вероятность ложного обнаружения
err_int=0;
An = zeros(1,R);
for Nexper=1:1
err_int=0;
% Процесс авторегресии первого порядка x(n) = a1*x(n-1)+g
% Процесс авторегресии второго порядка x(n) = a1*x(n-1)+a2*x(n-2)+g
a1=0.25;  % Коэффициент авторегресси a1
a2=0.5;  % Коэффициент авторегресси a2
A = [a1 a2; 1 0]; % Матрица состояния 
 
sigm = 1; % Дисперсия в канале возмущения
% Вычисляем дисперсию шума возмущения    
sigmx = sigm * sqrt( (1+a2)*((1-a2)^2-a1^2)/(1-a2) );
 
mu1 = 0; % МО шума возмущения
Msm = 0; % Постоянное смещение уровня шумов в канале измерения
Msv = 0; % постоянное смещение уровня шумов в канале возмущения
F = [1;0]; % Вектор входа по возмущению
    
% Параметры наблюдателя
C = [1 0]; % Вектор измерения по состоянию       
sigmy = 4; % Дисперсия шума измерения
Ksigmy = 8; % Множитель дисперсии шума измерения
Ksigmx = 1;
%Начальные условия
X1 = [0;0]; % Начальное наблюдение
P = [1 0; 0 1]; % Корреляционная матрица ошибок фильтрации
X1_=[sigmx;0]; % Начальная оценка наблюдения
 
%Счетчик цикла реализаций (дискретное время)
N = 1000;  
N1 = 500;  % при дефекте            
Zm = zeros(1,N); % размер матрицы                       
%Цикл реализации работы фильтра
for i=1:N
    %Моделирование наблюдений
    if i < N1
%        X1 = A*X1 + random('Normal',0,sqrt(sigmx));
%        Y = C*X1 + random('Normal',0,sqrt(sigmy));
       
       X1 = A*X1 + normrnd(0,sqrt(sigmx));
       Y = C*X1 + normrnd(0,sqrt(sigmy)); 

    else
%        X1 = A*X1 + random('Normal',Msv,sqrt(sigmx*Ksigmx));
%        Y = C*X1 + random('Normal',Msm,sqrt(sigmy*Ksigmy));
       X1 = A*X1 + normrnd(Msv,Ksigmx*sqrt(sigmx));
       Y = C*X1 + normrnd(Msm,Ksigmy*sqrt(sigmy));  
    end
    Xm(1,i) = X1(1,1);
    %Вычисление матричного коэффициента усиления
    %и корреляционной матрицы ошибок экстраполяции
    Q = A*P*A' + F*sigmx*F';
    K = Q*(C')*((C*Q*(C') + sigmy)^-1);
    P = Q - K*C*Q;
    %Оценка вектора состояния и вычисление обновляющей
    %последовательности
    X1_ = A*X1_ + F*mu1 + K*(Y - C*(A*X1_ + F*mu1));
    Z1 = Y - C*(A*X1_ + F*mu1);
    %нормировочный коэффициент
    S = sigmy + C*P*(C') - sigmy*(K')*(C') - C*K*sigmy;
    %нормируем обновляющую последовательность
    Z = (Z1)*(S^-0.5);
    Zm(1,i)=Z;
    
    % метод АОН
    h=sqrt(max(R,1));
    % сдвиг
    An=[An Zm(1,i)];
    An=An(1, 2:R+1);
    lambda = eig (An'*An);
    % сдвиг
    summl=[summl sqrt(max(lambda))];
    summl=summl(1,2:M+1);
    if i >= M+R
        G(1,i)=(1/M)*sum(summl);
        if (G(1,i)>=2*h)||(G(1,i)<=h)
            err_int(i)=1;
        else
            err_int(i)=0;
        end
    end
end
disp('N exp = ');disp(Nexper)
Plo=mean(err_int);
disp(Plo);
Ploexper(Nexper)=Plo;
end
disp('Ploexper');
disp(mean(Ploexper));
time = 1:N;
% disp(std(Ploexper)/sqrt(Nexper));
% disp('t_obn');
% disp(((1-mean(Ploexper))*N)-N1);
% h1_to_plot=ones(1,N)*h;
% h2_to_plot=ones(1,N)*2*h;
hFigure1 = figure('Color',[1 1 1]);
hAxes1 = axes('Visible','on','Parent',hFigure1);
box('on');
hold('all');
grid on; 
xlabel( hAxes1, 'Time','FontSize',10); ylabel(hAxes1, '','FontSize',10);   
plot(time, Zm,'color','blue');
plot(time, G,'color','black');
plot(time, h,'color','red');
plot(time, 2*h,'color','red');
plot(time, err_int-2,'color','cyan')
