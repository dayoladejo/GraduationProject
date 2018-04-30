addpath('C:\Users\wadii\OneDrive\Documents\GitHub\GraduationProjectOld\matlab\Building Topology and solving')

%% initial values
NumberOfPopulation=20;
Probability.matting=0.8;
Probability.mutation=0.01;
NumberOfItterations=10;
decimalPoints=10;
MutationPercentage=0.1;
LoadBalancing=0;

geneticsUsersNSGAIII=inUsersMore;
Pop=[];
Number_Of_genes=0;
%% NSGA-II Parameters
nPop=NumberOfPopulation;
pCrossover = Probability.matting;       % Crossover Percentage
nCrossover = 2*round(pCrossover*nPop/2); % Number of Parnets (Offsprings)

pMutation = 0.1;       % Mutation Percentage
nMutation = round(pMutation*nPop);  % Number of Mutants

nObj=2;
nDivision = 20;
Zr = GenerateReferencePoints(nObj, nDivision);

%% Colect Parameters
params.nPop = nPop;
params.Zr = Zr;
params.nZr = size(Zr,2);
params.zmin = [];
params.zmax = [];
params.smin = [];

%% initialization
empty_individual.Genes = [];
empty_individual.Cost = [];
empty_individual.Rank = [];
empty_individual.DominationSet = [];
empty_individual.DominatedCount = [];
empty_individual.NormalizedCost = [];
empty_individual.AssociatedRef = [];
empty_individual.DistanceToAssociatedRef = [];
pop = repmat(empty_individual, nPop, 1);

%% genrate population
pop=GeneratePopulation(inUsersMore,NumberOfPopulation);
firstPop=pop;
Number_Of_genes=length(firstPop(1).Genes);
[pop, F, params] = SortAndSelectPopulation(pop, params);


pop=pop';





%% corssover

for it=1:min([NumberOfItterations,10])
    
    popc = repmat(empty_individual,2 , nCrossover/2);
    
    for k = 1:nCrossover/2
        i1 = randi([1 nPop]);
        p1 = pop(i1);
        
        i2 = randi([1 nPop]);
        p2 = pop(i2);
        
        [popc(1,k).Genes, popc(2,k).Genes] = crossover(p1.Genes, p2.Genes);
        
        popc(1,k).Cost = CalculateFitnessGenes(popc(1,k).Genes);
        popc(2,k).Cost = CalculateFitnessGenes(popc(2,k).Genes);
        
    end
    
    
    popm = repmat(empty_individual, nMutation, 1);
    if(nMutation~=0)
        for k = 1:nMutation
            
            i = randi([1 nPop]);
            p = pop(i);
            
            popm(k).Genes = mutate(p.Genes,MutationPercentage);
            popm(k).Cost = CalculateFitnessGenes(popm(k).Genes);
            
        end
    end
    
    
    
    popc = popc(:);
    pop = [pop
        popc];
    
    
    [pop, F, params] = SortAndSelectPopulation(pop, params);
    
    F1 = pop(F{1});
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': Number of F1 Members = ' num2str(numel(F1))]);
    
    % Plot F1 Costs
    figure;hold on;
    PlotCosts(F1);
    pause(0.01);
    
    
end
%% final result

resultArrayNSGAIII=F1(1).Genes;
for i=1:length(geneticsUsersNSGAIII)
    index=find(resultArrayNSGAIII(i).binary,1);
    geneticsUsersNSGAIII(i).CellConnectingTo=resultArrayNSGAIII(i).cell(1:3,index);
    geneticsUsersNSGAIII(i).SINR=resultArrayNSGAIII(i).cell(5,index);
    geneticsUsersNSGAIII(i).powerRecived=resultArrayNSGAIII(i).cell(6,index);
end
geneticsUsersNSGAIII=[geneticsUsersNSGAIII,inUsersOne];
figure;hold on;
DrawTopology(AllClusters,AllMacroCells,geneticsUsersNSGAIII,AllCellsArray,background);
set(gca,'Color','k');


