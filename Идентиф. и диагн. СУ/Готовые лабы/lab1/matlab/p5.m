clear all
n = 2000 
a1 = 0.25
a2 = 0.7
mx=0   
sigm=1
sigmag=(sigm^2*(1+a2)*((1-a2)^2-a1^2)/(1-a2))^0.5;
x0=0; 
x1=0; 
for i=1:n
    g=randn*sigmag;
    x=mx+a1*(x1-mx)+a2*(x0-mx)+g;
    xm(1,i)=x;
    x0=x1;
    x1=x;
end
mo_=mean(xm)
sigm_=std(xm)
r=arcov(xm(1000:n)',2) ;
a1_=-r(2)
a2_=-r(3)

figure('color', 'white', 'Position',[200 100 600 400])

plot(xm);
grid on