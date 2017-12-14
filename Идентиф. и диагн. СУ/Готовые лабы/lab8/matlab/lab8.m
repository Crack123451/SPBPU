clc, clear all, echo off
 
M = 40;       %������� ������ ���������
R = 70;       %������� ������ ����������� �������
summl=zeros(1,M);
 
Plo = 0;     %����������� ������� �����������
err_int=0;
An = zeros(1,R);
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
Msv = 1; % ���������� �������� ������ ����� � ������ ����������
F = [1;0]; % ������ ����� �� ����������
    
% ��������� �����������
C = [1 0]; % ������ ��������� �� ���������       
sigmy = 4; % ��������� ���� ���������
Ksigmy = 1; % ��������� ��������� ���� ���������
Ksigmx = 1;
%��������� �������
X1 = [0;0]; % ��������� ����������
P = [1 0; 0 1]; % �������������� ������� ������ ����������
X1_=[sigmx;0]; % ��������� ������ ����������
 
%������� ����� ���������� (���������� �����)
N = 1000;
n = N;
N1 = 500;  % ��� �������            
Zm = zeros(1,N); % ������ �������                       
%���� ���������� ������ �������
for i=1:N
    %������������� ����������
    if i < N1
       X1 = A*X1 + normrnd(0,sqrt(sigmx));
       Y = C*X1 + normrnd(0,sqrt(sigmy)); 
    else
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
    Znorm(1,i)=Z;
    
    % ����� ���
    h=sqrt(max(R,1));
    % �����
    An=[An Znorm(1,i)];
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

Plo=mean(err_int);
disp ('ANOM'); disp(Plo);

%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gamma = 0.2;
delta = 0.2;
Pdov=0.95;
M=100;
% ����������� �������
Z_gamma = double(solve(sprintf('%f - 0.5 = 0.5 * erf(x/sqrt(2))', gamma)));
Z_inf = double(solve(sprintf('%f = erf(x/sqrt(2))', delta)));

for i=1:n
%������������ �����
    if i<=M
        n=i;
    else
        n=M;  
    end
    mn=mean(Znorm(1,i-n+1:i));
    Sn=std(Znorm(1,i-n+1:i));
    Kn = Z_inf * (1 + (Z_gamma / sqrt(2 * n)) + (5 * Z_gamma ^ 2 + 10) / (12 * n));
    if i<=M
        l1(i)=mn-Kn*Sn;
        l2(i)=mn+Kn*Sn;
    else
        l1(i)=l1(i-1);
        l2(i)=l2(i-1);
    end
    if (n>2)
        % ������� �������� ���������
        t_st=tinv(1-(1-Pdov)/2,n-1);
        % ������ u1 � u2
        u1(i)=mn-t_st*Sn/sqrt(n);
        u2(i)=mn+t_st*Sn/sqrt(n);
      % ������� � ������� �������
        if (l1(i)>u2(i)||l2(i)<u1(i))
            err_anom(i)=1;
        else
            err_anom(i)=0;
        end
        
        err(i+5) = err_anom(i) * err_int(i);

    end
end
disp ('Inte');
disp(mean(err_anom));
disp ('RES');
disp(mean(err));

time = 1:N;
hFigure1 = figure('Color',[1 1 1]);
hAxes1 = axes('Visible','on','Parent',hFigure1);
box('on');
hold('all');
grid on; 
xlabel( hAxes1, 'Time','FontSize',10); ylabel(hAxes1, '','FontSize',10);   
plot(time, Znorm,'color','blue');
plot(time, G,'color','black');
plot(time, h,'color','red');
plot(time, 2*h,'color','red');
plot(time, err_int-3,'color','green');
plot(1:1005, err - 4, 'color', 'black');
xlim([0 1000]);



hFigure2 = figure('Color',[1 1 1]);
hAxes2 = axes('Visible','on','Parent',hFigure2);
box('on');
hold('all');
grid on; 
xlabel( hAxes2, 'Time','FontSize',10); ylabel(hAxes2, 'u1, u2, l1, l2','FontSize',10);   
ylim([-5 20]);
xlim([0 1000]);

plot(time, Znorm);
plot(time,l1+10,'color','red');
plot(time,l2+10,'color','red');
plot(time, u1+10,'color','blue');
plot(time, u2+10,'color','blue');
plot(time, err_anom-3,'color','green','LineWidth',1);
plot(1:1005, err - 4, 'color', 'black');
grid on;

