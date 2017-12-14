clc
clear all
global M;
global D;
global q1;
global q2;
M=0;
D=1;
q1=0.9;
q2=0.95;

x=fsolve(@fun1,1);