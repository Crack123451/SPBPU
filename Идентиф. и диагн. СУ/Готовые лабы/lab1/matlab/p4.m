clear all
clc
n=1000;
a1=0.25;
mx=0;
sigm=1;
sigmag=sigm*sqrt(1-a1^2);
x1=0; 
for i=1:n
    g=randn*sigmag;
    x=mx+a1*(x1-mx)+g;
    xm(1,i)=x;
    x1=x;
end

mo_=mean(xm)
sigm_=std(xm)
r=covf2(xm',5) 
disp('ќценка a1')
a1_=r(2)

figure('color', 'white', 'Position',[200 100 600 400])
grid on
hold on;
plot(xm(1:1000));
