function [xq, fval, exitflag, output, population, score] = InitF(FName, SheetName, RangeName, N0)
%          Function variant of InitW

global N0 LB UB CorM K MTraj MR IntA delta;
%                N0 = 14;
K= 3;
MTraj = zeros(N0, 1000);
LB = zeros(1, (N0+3)*N0/2) ;
UB = zeros(1, (N0+3)*N0/2,1);
delta = 0.5;

IntA = zeros(1, (N0+3)*N0/2,1);
IntA(1:(N0+3)*N0/2)=1:(N0+3)*N0/2;

LB((N0+1)*N0/2+1:(N0+1)*N0/2+N0)=1;

UB(1:N0)=2;
UB(N0+1:(N0+1)*N0/2)=8;
UB((N0+1)*N0/2:(N0+1)*N0/2+N0)=K;

CorM = xlsread(FName, SheetName, RangeName);

MR = zeros(N0);

%% clc;
[xq,fval,exitflag,output,population,score] =uW((N0+3)*N0/2, LB,UB, IntA, 4000, 300, 80);



end

