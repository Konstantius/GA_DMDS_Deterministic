function [xq,fval,exitflag,output,population,score] = uW(nvars,lb,ub,intcon,PopulationSize_Data,Generations_Data,StallGenLimit_Data)
%% This is an auto generated MATLAB file from Optimization Tool.

%% Start with the default options
options = gaoptimset;
%% Modify options setting
options = gaoptimset(options,'PopulationSize', PopulationSize_Data);
options = gaoptimset(options,'Generations', Generations_Data);
options = gaoptimset(options,'StallGenLimit', StallGenLimit_Data);
options = gaoptimset(options,'Display', 'diagnose');
options = gaoptimset(options,'EliteCount', 15);
options = gaoptimset(options,'CrossoverFraction', 0.9);
%% options = gaoptimset(options,'PlotFcns', {  @gaplotbestf  }); %     @gaplotbestindiv
[xq,fval,exitflag,output,population,score] = ga(@dproxW,nvars,[],[],[],[],lb,ub,[],intcon,options);
