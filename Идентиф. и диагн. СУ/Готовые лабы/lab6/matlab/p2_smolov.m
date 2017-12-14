clc, clear all, echo off
 
M = 40;       %������� ������ ���������
R = 40;       %������� ������ ����������� �������
summl=zeros(1,M);
 
Plo = 0;     %����������� ������� �����������
err_int=0;
An = zeros(1,R);
for Nexper=1:1
err_int=0;
% ������� ������������ ������� ������� x(n) = a1*x(n-1)+g
% ������� ������������ ������� ������� x(n) = a1*x(n-1)+a2*x(n-2)+g
a1=0.25;  % ����������� ������������ a1
a2=0.5;  % ����������� ������������ a2
A = [a1 a2; 1 0]; % ������� ��������� 
 
sigm = 1; % ��������� � ������ ����������
% ��������� ��������� ���� ����������    
sigmx = sigm * sqrt( (1+a2)*((1-a2)^2-a1^2)/(1-a2) );
 
mu1 = 0; % �� ���� ����������
Msm = 0; % ���������� �������� ������ ����� � ������ ���������
Msv = 0; % ���������� �������� ������ ����� � ������ ����������
F = [1;0]; % ������ ����� �� ����������
    
% ��������� �����������
C = [1 0]; % ������ ��������� �� ���������       
sigmy = 4; % ��������� ���� ���������
Ksigmy = 8; % ��������� ��������� ���� ���������
Ksigmx = 1;
%��������� �������
X1 = [0;0]; % ��������� ����������
P = [1 0; 0 1]; % �������������� ������� ������ ����������
X1_=[sigmx;0]; % ��������� ������ ����������
 
%������� ����� ���������� (���������� �����)
N = 1000;  
N1 = 500;  % ��� �������            
Zm = zeros(1,N); % ������ �������                       
%���� ���������� ������ �������
for i=1:N
    %������������� ����������
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
    %���������� ���������� ������������ ��������
    %� �������������� ������� ������ �������������
    Q = A*P*A' + F*sigmx*F';
    K = Q*(C')*((C*Q*(C') + sigmy)^-1);
    P = Q - K*C*Q;
    %������ ������� ��������� � ���������� �����������
    %������������������
    X1_ = A*X1_ + F*mu1 + K*(Y - C*(A*X1_ + F*mu1));
    Z1 = Y - C*(A*X1_ + F*mu1);
    %������������� �����������
    S = sigmy + C*P*(C') - sigmy*(K')*(C') - C*K*sigmy;
    %��������� ����������� ������������������
    Z = (Z1)*(S^-0.5);
    Zm(1,i)=Z;
    
    % ����� ���
    h=sqrt(max(R,1));
    % �����
    An=[An Zm(1,i)];
    An=An(1, 2:R+1);
    lambda = eig (An'*An);
    % �����
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
