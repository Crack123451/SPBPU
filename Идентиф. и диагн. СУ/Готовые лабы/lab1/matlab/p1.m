clear all;
figure('color', 'white')
grid on;
set(gca,'FontName','Arial Cyr')
N=[10,20,50,100,1000];
M=1;
D=4;
q=[0.9, 0.95];
Aver=zeros(1,5);
Dev=zeros(1,5);
for i=1:5
    x=normrnd(M,D,1,N(i));
    Aver(i)=mean(x);
    Dev(i)=std(x);
end
% матрицы для доверительных интервалов
M_9=zeros(2,5);
M_95=zeros(2,5);
hold on
for i=1:5
    M_9(1,i) = Aver(i)-tinv((1+q(1))/2, N(i)-1)*Dev(i)/sqrt(N(i));
    M_9(2,i) = Aver(i)+tinv((1+q(1))/2, N(i)-1)*Dev(i)/sqrt(N(i));
    
    M_95(1,i) = Aver(i)-tinv((1+q(2))/2, N(i)-1)*Dev(i)/sqrt(N(i));
    M_95(2,i) = Aver(i)+tinv((1+q(2))/2, N(i)-1)*Dev(i)/sqrt(N(i));
end
D_9=zeros(2,5);
D_95=zeros(2,5);
hold on
for i=1:5
    D_9(1,i) = sqrt((Dev(i)^2)*(N(i)-1)/chi2inv((1+q(1))/2,N(i)-1));
    D_9(2,i) = sqrt((Dev(i)^2)*(N(i)-1)/chi2inv((1-q(1))/2,N(i)-1));
    
    D_95(1,i) = sqrt((Dev(i)^2)*(N(i)-1)/chi2inv((1+q(2))/2,N(i)-1));
    D_95(2,i) = sqrt((Dev(i)^2)*(N(i)-1)/chi2inv((1-q(2))/2,N(i)-1));
end
 
disp('N:      10        20        50       100      1000');
disp(' ');
disp('Интервальная оценка мат. ожидания:');
disp('q=0.9');
disp(M_9);
disp('q=0.95');
disp(M_95);
disp('Интервальная оценка дисперсии:');
disp('q=0.9');
disp(D_9);
disp('q=0.95');
disp(D_95);
disp('Точечная оценка мат. ожидания:');
disp(Aver);
disp('Точечная оценка дисперсии:');
disp(Dev);
 
plot(N, M_9(1,:),'k*',N, M_95(1,:),'r+',N,Aver,'b.',N,M_9(2,:),'k*',N, M_95(2,:),'r+',[10,1000],[M,M]);
xlabel('n');
ylabel('M');
 legend('Интервальная оценка мат. ожидания, q=0.9','Интервальная оценка мат. ожидания, q=0.95', 'Точечная оценка мат. ожидания');
 
figure('color', 'white')
grid on;
set(gca,'FontName','Arial Cyr')
hold on
plot(N, D_9(1,:),'k*',N, D_95(1,:),'r+',N,Dev,'b.',N, D_9(2,:),'k*',N, D_95(2,:),'r+',N,Dev,'b.',[10,1000],[D,D]);
xlabel('n');    
ylabel('D');
% legend('Интервальная оценка дисперсии, q=0.9','Интервальная оценка дисперсии, q=0.95', 'Точечная оценка дисперсии');
