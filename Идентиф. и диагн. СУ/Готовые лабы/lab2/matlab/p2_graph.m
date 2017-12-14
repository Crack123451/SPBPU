NRUNS_lin = [6 10 20 40];
eps_lin = [67 64 70 73]/100;

NRUNS_int = [16 25 50 100];
eps_int = [21 23 24 28]/100;

NRUNS_pquad = [11 20 40 80];
eps_pquad = [64 64 66 69]/100;

NRUNS_quad = [21 30 60 120];
eps_quad = [79 77 79 84]/1000;

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
