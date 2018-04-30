addpath('C:\Users\wadii\OneDrive\Documents\GitHub\GraduationProjectOld\matlab\Building Topology and solving')
[geneticsUsers1,resultArray1,initial1,result1,PopulationArrayResult]=SingleObjectiveGeneticsFun(Users,inUsersMore,AllCellsArray,NumberOfPopulation,NumberOfItterations,Probability.matting,Probability.mutation,decimalPoints,MutationPercentage,LoadBalancing,CellUsersOne);%without loadBalancing
geneticsUsers1=[geneticsUsers1,inUsersOne];
figure;hold on;
DrawTopology(AllClusters,AllMacroCells,geneticsUsers1,AllCellsArray,background);
set(gca,'Color','k');