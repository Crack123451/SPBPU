clc, clear, echo off
% �������� �������
gamma = 0.4;
delta = 0.5;
Pdov=0.95;
M=100;

% ��������� ����������� �����������
mux = 0; % �� ���� ����������
muy = 0; % MO ���� ���������
sigmx = 1; % ��������� ���� ����������
sigmy = 4; % ��������� ���� ���������

shx = 2;
shy = 0;
dx = 1;
dy = 1;


% ������� ������������ ������� ������� x(n) = a1*x(n-1)+g
% ������� ������������ ������� ������� x(n) = a1*x(n-1)+a2*x(n-2)+g
a1=0.25;  % ����������� ������������ a1
a2=0.5;  % ����������� ������������ a2
A = [a1 a2; 1 0]; % ������� ��������� 


%mu1 = 0; % �� ���� ����������
%Msm = 3; % ���������� �������� ������ ����� � ������ ���������
%Msv = 3; % ���������� �������� ������ ����� � ������ ����������
F = [1;0]; % ������ ����� �� ����������

% ��������� �����������
C = [1 0]; % ������ ��������� �� ���������       
%��������� �������
X1 = [0;0]; % ��������� ����������
P = sigmy*[1 0; 0 1]; % �������������� ������� ������ ����������
X1_=[0;0]; % ��������� ������ ����������

%������� ����� ���������� (���������� �����)
n = 1000;
time = 1:n;
n_er = 500;  % ��� �������            
Znorm = zeros(1,n); % ������ �������                       
%���� ���������� ������ �������
for i=1:n
    
    % ������������� ���������
    if i < n_er
       X1 = A*X1 + normrnd(mux,sigmx);
       Y = C*X1 + normrnd(muy,sigmy); 
    else
       X1 = A*X1 + normrnd(mux+shx,sigmx*dx);
       Y = C*X1 + normrnd(muy+shy,sigmy*dy);
    end
    Xm(1,i) = X1(1,1);
    %���������� ���������� ������������ ��������
    %� �������������� ������� ������ �������������
    Q = A*P*A' + F*sigmx*F';
    K = Q*(C')*((C*Q*(C') + sigmy)^-1);
    P = Q - K*C*Q;
    %������ ������� ��������� � ���������� �����������
    %������������������
    X1_ = A*X1_ + F*mux + K*(Y - C*(A*X1_ + F*mux));
    Z1 = Y - C*(A*X1_ + F*mux);
    Zi(i)=Z1;
    %������������� �����������
    S = sigmy + C*P*(C') - sigmy*(K')*(C') - C*K*sigmy;
    %��������� ����������� ������������������
    Z = (Z1)*(S^-0.5);
    Znorm(1,i)=Z;
end    

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
%         if (u1(i)<l1(i)||u2(i)>l2(i))
            err(i)=1;
        else
            err(i)=0;
        end
    end
end
Plo=mean(err);

disp('Gamma=')
disp(gamma);
disp('Plo=')
disp(Plo);


hFigure1 = figure('Color',[1 1 1]);
hAxes1 = axes('Visible','on','Parent',hFigure1);
box('on');
hold('all');
grid on; 
xlabel( hAxes1, 'Time','FontSize',10); ylabel(hAxes1, 'u1, u2, l1, l2','FontSize',10);   
ylim([-4 6]);

plot(time,l1,'color','red');
plot(time,l2,'color','red');
plot(time, u1,'color','blue');
plot(time, u2,'color','blue');
plot(time, err-3,'color','black','LineWidth',2);
grid on;

n/2 - Plo*n


