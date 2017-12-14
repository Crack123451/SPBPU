function I = lab5_3(Y,T,Tf,a00,a01,a10,a11,b0,b1)
[m,n] = size(Y);
U = ones(m,1);
Z = zeros(m,1);
I = zeros(m,1);
Z(1) = (a10*T+a00*T^2)*Y(1,1)+(a11*T+a01*T^2)*Y(1,2)+b0*T^2*U(1);
Z(2) = 2*Z(1)+(a10*T+a00*T^2)*Y(2,1)-(a10*T)*Y(1,1)+(a11*T+a01*T^2)*Y(2,2)-(a11*T)*Y(1,2)+b0*T^2*U(2);

for i = 3:m
    Z(i) = 2*Z(i-1)-Z(i-2)+(a10*T+a00*T^2)*Y(i,1)-(a10*T)*Y(i-1,1)+(a11*T+a01*T^2)*Y(i,2)-(a11*T)*Y(i-1,2)+b0*T^2*U(2);
    I(i) = Y(i,1)+Y(i,2)+Z(i)+T^2*i;
end