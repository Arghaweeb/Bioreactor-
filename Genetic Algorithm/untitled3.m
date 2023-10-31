clc;
clear;
close all;

%% Problem Defination

problem.CostFunction = @MinOne;
problem.nVar = 10;



%% GA Parameters

params.MaxIt = 100;
params.nPop = 20;



%% Run GA 
out = RunGA(problem, params)

%% Results 