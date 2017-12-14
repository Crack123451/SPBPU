NRUNS_lin = [6 10 20 40];
eps_lin = [190 87 113 72]/100;

NRUNS_int = [16 25 50 100];
eps_int = [32 30 32 31]/100;

NRUNS_pquad = [11 20 40 80];
eps_pquad = [104 107 92 64]/100;

NRUNS_quad = [21 30 60 120];
eps_quad = [230 230 110 93]/1000;

figure('color', 'white')
grid on;
set(gca,'FontName','Arial Cyr')
hold on
plot(   NRUNS_lin, eps_lin,'k*',...
        NRUNS_int, eps_int,'r+',...
        NRUNS_pquad, eps_pquad, 'b.',...
        NRUNS_quad, eps_quad, 'go');
xlabel('NRUNS');    
ylabel('eps');
legend('Модель linear','Модель interaction', 'Модель purequadratic', 'Модель quadratic');
