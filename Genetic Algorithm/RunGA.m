function out  = RunGA(problem, params)

     %nProblem
     CostFunction = problem.CostFunction;
     nVar = problem.nVar;

     %Params 
     MaxIt = params.MaxIt;
     nPop = params.nPop;

     %Template for EMpty Individual
     empty_individual.Position = [];
     empty_individual.Cost = [];

     %Initialization
     pop = repmat(empty_individual, nPop, 1);
     for i = i:nPop
         pop(i).Position = 


end 