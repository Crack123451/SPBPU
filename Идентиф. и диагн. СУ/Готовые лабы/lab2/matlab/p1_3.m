clc;
NFACTORS=5;

x1=[1 2];
x2=[2 3];
x3=[3 4];
x4=[4 5];
x5=[5 6];


X=[ %Середина интервала //  отклонение
   (x1(1)+x1(2))/2          (x1(2)-x1(1))/2;
   (x2(2)+x2(1))/2          (x2(2)-x2(1))/2;
   (x3(2)+x3(1))/2          (x3(2)-x3(1))/2;
   (x4(2)+x4(1))/2          (x4(2)-x4(1))/2;
   (x5(2)+x5(1))/2          (x5(2)-x5(1))/2];

NRUNS=6;
S = S_linear;

for i=1:NRUNS
    for j=1:NFACTORS
        XRES(i,j)=X(j,1)+X(j,2)*S(i,j);
    end
end
Y=-XRES(:,3) + XRES(:,1).^(XRES(:,2))+2*XRES(:,3).*XRES(:,4).*XRES(:,5);
rstool(XRES,Y,'linear')

pause
beta_linear = beta3

NRUNS=16;
S = S_interaction;

for i=1:NRUNS
    for j=1:NFACTORS
        XRES(i,j)=X(j,1)+X(j,2)*S(i,j);
    end
end

Y=-XRES(:,3) + XRES(:,1).^(XRES(:,2))+2*XRES(:,3).*XRES(:,4).*XRES(:,5);
rstool(XRES,Y,'interaction')
 
pause
beta_interaction = beta4


NRUNS=11;
S = S_purequadratic;

for i=1:NRUNS
    for j=1:NFACTORS
        XRES(i,j)=X(j,1)+X(j,2)*S(i,j);
    end
end

Y=-XRES(:,3) + XRES(:,1).^(XRES(:,2))+2*XRES(:,3).*XRES(:,4).*XRES(:,5);
rstool(XRES,Y,'purequadratic')
 
pause
beta_purequadratic = beta5

NRUNS=21;
S = S_quadratic;

for i=1:NRUNS
    for j=1:NFACTORS
        XRES(i,j)=X(j,1)+X(j,2)*S(i,j);
    end
end

Y=-XRES(:,3) + XRES(:,1).^(XRES(:,2))+2*XRES(:,3).*XRES(:,4).*XRES(:,5);
rstool(XRES,Y,'quadratic')

pause
beta_quadratic = beta6
