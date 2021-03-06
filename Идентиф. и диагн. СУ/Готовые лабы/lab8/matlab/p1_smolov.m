clc, clear, echo off
gamma = 0.9;
delta = 0.05;
Pdov=0.95;
M=100;
% ����������� �������
Z_0 = double(solve(sprintf('%f - 0.5 = 0.5 * erf(x/sqrt(2))', gamma)));
Z_inf = double(solve(sprintf('%f = erf(x/sqrt(2))', delta)));
 
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
%��������� �������
X1 = [0;0]; % ��������� ����������
P = [1 0; 0 1]; % �������������� ������� ������ ����������
X1_=[sigmx;0]; % ��������� ������ ����������
 
%������� ����� ���������� (���������� �����)
n = 5000;  
time = 1:n;
n1 = 2500;  % ��� �������            
Zm = zeros(1,n); % ������ �������                       
%���� ���������� ������ �������
for i=1:n
    %������������� ����������
    if i < n1
        X1 = A*X1 + sigmx*(randn);
        Y = C*X1 + sigmy*(randn);
    else
        X1 = A*X1 + sigmx*(randn+Msv);
        Y = C*X1 + sigmy*4*(randn + Msm);
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
    %������������ �����
    if i<=M
        n=i;
    else
        n=M;  
    end
    mn=mean(Zm(1,i-n+1:i));
    Sn=std(Zm(1,i-n+1:i));
    % ������� ����������� ��������� Kn
    Kn = Z_inf * (1 + (Z_0 / sqrt(2 * n)) + (5 * Z_0 ^ 2 + 10) / (12 * n));
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
            err_int(i)=1;
        else
            err_int(i)=0;
        end
    end
end
Plo=mean(err_int)

% plot(time,l1,time,l2,time, u1,time, u2)

