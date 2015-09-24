function [xq,fval,exitflag,output,population,score] = MFuncSpearman(ExcelFileName, SheetName, RangeName, LevelsNumber, VarNum, PopulationSize, GenerationsNumber, StallGen)
% Main function for DMDS model building
% Weight functions' approach
% Call: MFuncSpearman(ExcelFileName, SheetName, RangeName, LevelsNumber, VarNum, PopulationSize, GenerationsNumber, StallGen)
% Return: xq,fval,exitflag,output,population,score
global N0 LB UB CorM K MTraj MR IntA delta;
N0 = VarNum;
K= LevelsNumber;
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

CorM = xlsread(ExcelFileName, SheetName, RangeName);

MR = zeros(N0);
clc;
%% clc;
[xq,fval,exitflag,output,population,score] =  uW((N0+3)*N0/2, LB,UB, IntA, PopulationSize,  GenerationsNumber, StallGen);
end