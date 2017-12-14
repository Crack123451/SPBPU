clc

Ntest = 10000;

X1=[1 2];
X2=[2 3];
X3=[3 4];
X4=[4 5];
X5=[5 6];

for i = 1: Ntest

    x1=X1(1)+(X1(2)-X1(1))*rand(1,1);
    x2=X2(1)+(X2(2)-X2(1))*rand(1,1);
    x3=X3(1)+(X3(2)-X3(1))*rand(1,1);
    x4=X4(1)+(X4(2)-X4(1))*rand(1,1);  
    x5=X5(1)+(X5(2)-X5(1))*rand(1,1); 

    beta = beta_linear;
    y_linear = beta(1) + beta(2)*x1 + beta(3)*x2 + beta(4)*x3+beta(5)*x4+beta(6)*x5;

    beta = beta_interaction;
    y_interaction = beta(1) + beta(2)*x1 + beta(3)*x2 + beta(4)*x3+beta(5)*x4+beta(6)*x5...
                    +beta(7)*x1*x2+beta(8)*x1*x3+beta(9)*x1*x4+beta(10)*x1*x5+beta(11)*x2*x3...
                    +beta(12)*x2*x4 +beta(13)*x2*x5+beta(14)*x3*x4+beta(15)*x3*x5+beta(16)*x4*x5;    

    beta = beta_purequadratic;
    y_purequadratic = beta(1) + beta(2)*x1 + beta(3)*x2 + beta(4)*x3+beta(5)*x4+beta(6)*x5...
                      +beta(7)*x1*x1+beta(8)*x2*x2+beta(9)*x3*x3+beta(10)*x4*x4+beta(11)*x5*x5;


    beta = beta_quadratic;
    y_quadratic = beta(1) + beta(2)*x1 + beta(3)*x2 + beta(4)*x3+beta(5)*x4+beta(6)*x5...
                  +beta(7)*x1*x2+beta(8)*x1*x3+beta(9)*x1*x4+beta(10)*x1*x5+beta(11)*x2*x3...
                  +beta(12)*x2*x4 +beta(13)*x2*x5+beta(14)*x3*x4+beta(15)*x3*x5+beta(16)*x4*x5...
                  +beta(17)*x1*x1+beta(18)*x2*x2+beta(19)*x3*x3+beta(20)*x4*x4+beta(21)*x5*x5;

    yt = -x3 + x1.^x2 + 2*x3.*x4.*x5;

    eps_linear_array(i) = abs((y_linear-yt)/yt);
    eps_interaction_array(i) = abs((y_interaction-yt)/yt);
    eps_purequadratic_array(i) = abs((y_purequadratic-yt)/yt); 
    eps_quadratic_array(i) = abs((y_quadratic-yt)/yt);

end

eps_linear = max(eps_linear_array)
eps_interaction = max(eps_interaction_array)
eps_purequadratic = max(eps_purequadratic_array)
eps_quadratic = max(eps_quadratic_array)
