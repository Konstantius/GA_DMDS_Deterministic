global N0 LB UB CorM K MTraj MR IntA delta;
N0 = 20;
K= 3;
MTraj = zeros(N0, 1000);
LB = zeros(1, (N0+3)*N0/2) ;
%        UB = zeros(1, (N0+3)*N0/2,1);
UB = zeros(1, (N0+3)*N0/2);
delta = 0.5;

IntA = zeros(1, (N0+3)*N0/2);
IntA(1:(N0+3)*N0/2)=1:(N0+3)*N0/2;

LB((N0+1)*N0/2+1:(N0+1)*N0/2+N0)=1;
UB((N0+1)*N0/2+1:(N0+1)*N0/2+N0)=K;

UB(1:N0)=2;
UB(N0+1:(N0+1)*N0/2)=8;


CorM = xlsread('c:\MDS\DATASTAT\Rats-DMDS.xlsx', 'DMDS-2015', 'b175:u194');

MR = zeros(N0);
clc;
               

[xq, fval, exitflag, output, population, score] =uW((N0+3)*N0/2, LB,UB, IntA, 1200, 130, 80);