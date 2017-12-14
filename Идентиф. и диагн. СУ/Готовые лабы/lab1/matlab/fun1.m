function [ output_args ] = fun1( N )

global M;
global D;
global q1;

output_args = 2*tinv((1+q1)/2, N-1)*std(normpdf(M,D,N))/sqrt(N) - 0.1;
end

