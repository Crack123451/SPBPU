clear all
r=0.27-1;
R=[1,r;r,1];
N=[10,20,50,100,1000];
a = [0.9,0.95];
R_9 = zeros(2,5);
R_95 = zeros(2,5);
r_coeff=zeros(1,5);
 
q1=chol(R);
q=q1';
for i=1:5
    z1=zeros(N(i),2); 
    z2=z1;
    for j=1:N(i)
        x1=randn(2,1);
        z1(j,:)=x1';
        x2=q*x1;
        z2(j,:)=x2';
    end
    r2=cov(z2);
    KK=r2(1,2)/sqrt(r2(1,1)*r2(2,2));
    r_coeff(i)=KK;
    z=1/2*log((1+KK)/(1-KK));
    d=norminv((1+a(1))/2)*sqrt(1/(N(i)-3));
    R_9(1,i)=(exp(2*z-2*d)-1)/(exp(2*z-2*d)+1);
    R_9(2,i)=(exp(2*z+2*d)-1)/(exp(2*z+2*d)+1);
 
    d=norminv((1+a(2))/2)*sqrt(1/(N(i)-3));
    R_95(1,i)=(exp(2*z-2*d)-1)/(exp(2*z-2*d)+1);
    R_95(2,i)=(exp(2*z+2*d)-1)/(exp(2*z+2*d)+1);
end
 
disp('N:      10        20        50       100      1000');
disp(' ');
disp('Интервальная оценка коэффициента корреляции:');
disp('q=0.9');
disp(R_9);
disp('q=0.95');
disp(R_95);
disp('Точечная оценка коэффициента корреляции:');
disp(r_coeff);
 
scrsz = get(0,'ScreenSize');
figure('color', 'white', 'Position',[200 100 600 400])
grid on
set(gca,'FontName','Arial Cyr')
hold on
plot(N, R_9(1,:),'k*',N, R_95(1,:),'r+', N, r_coeff, 'b.', N, R_9(2,:),'k*', N, R_95(2,:),'r+',[0,1000],[r,r]);
%legend('Интервальная оценка коэффициента корреляции, q=0.9','Интервальная оценка коэффициента корреляции, q=0.95', 'Точечная оценка коэффициента корреляции');
xlabel('n');
ylabel('R');
 
% figure('color', 'white', 'Position',[200 100 600 400])
% 
% plot(z1(1:1000,1), z1(1:1000,2),'r.')
% grid on
% figure('color', 'white', 'Position',[200 100 600 400])
% 
% plot(z2(1:1000,1), z2(1:1000,2),'b.')
% grid on
