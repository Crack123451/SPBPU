clc, clear, echo off
gamma = 0.20;
delta = 0.10;
Pdov=0.95;
M=20;
T_obn = 0;
% ����������� �������
Z_y = double(solve(sprintf('%f - 0.5 = 0.5 * erf(x/sqrt(2))', gamma)));
Z_inf = double(solve(sprintf('%f = erf(x/sqrt(2))', delta)));
 
% ������� ������������ ������� ������� x(n) = a1*x(n-1)+g
% ������� ������������ ������� ������� x(n) = a1*x(n-1)+a2*x(n-2)+g
a1=0.35;  % ����������� ������������ a1
a2=0.5;  % ����������� ������������ a2
A = [a1 a2; 1 0]; % ������� ��������� 
 
sigm = 1; % ��������� � ������ ����������
% ��������� ��������� ���� ����������    
sigmx = sigm * sqrt( (1+a2)*((1-a2)^2-a1^2)/(1-a2) );
 
mu1 = 2; % �� ���� ����������
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
n = 1000;  
n1 = 1000;  % ��� �������
Zi = zeros(1, n);
Zm = zeros(1, n);   % ������ �������                       
%���� ���������� ������ �������
for i=1:n
    %������������� ����������
    if i < n1
        X1 = A*X1 + sigmx*(randn);
        Y = C*X1 + sigmy*(randn);
    else
        X1 = A*X1 + sigmx*(randn+Msv);
        Y = C*X1 + sigmy*6*(randn + Msm);
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
    Zi(i) = Z1;
    %������������� �����������
    S = sigmy + C*P*(C') - sigmy*(K')*(C') - C*K*sigmy;
    %��������� ����������� ������������������
    Z = (Z1)*(S^-0.5);
    Zm(1,i)=Z;
   
    % ��������� ������������������ �������
    r = covf2(Zm',10);
 
    %������������ �����
    if i<=M
        n=i;
    else
        n=M;  
    end
    mn=mean(Zm(1,i-n+1:i));
    Sn=std(Zm(1,i-n+1:i));
    % ������� ����������� ��������� Kn
    Kn = Z_inf * (1 + (Z_y / sqrt(2 * n)) + (5 * Z_y ^ 2 + 10) / (12 * n));
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
            if T_obn == 0
                T_obn = i;
            end
        end
    end
end
Plo=mean(err_int)
T_obn
    figure('color', 'white')
    hold on   
    subplot(3,1,1);
    plot(Zi,'r');
    grid;
    xlabel('t');
    ylabel('Z');
    set(gca,'FontName','Arial Cyr');
    title('����������� �������');
    
    subplot(3,1,2);
    plot(Zm,'b');
    grid;
    xlabel('t');
    ylabel('Zn');
    set(gca,'FontName','Arial Cyr');
    title('��������������� ����������� �������');
 
        subplot(3,1,3);
    plot(r,'g');
    grid;
    xlabel('t');
    ylabel('r');
    set(gca,'FontName','Arial Cyr');
    title('�������������� �������');
 
    
figure('color', 'white')
hold on
grid on
plot(u1)
plot(u2)
plot(l1, 'r')
plot(l2, 'r')
