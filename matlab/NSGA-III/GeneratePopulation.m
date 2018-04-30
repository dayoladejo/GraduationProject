function PopulationArray = GeneratePopulation(Users,NumberOfPopulation)
for k=1:NumberOfPopulation
    NewUsersArray=[];
    OverAllFitness=0;
    for j=1:length(Users)
        user=Users(j);
        if length(user.AllPossibleCells(1,:))>=2
            x.binary=[];
            x.cell=[];
            x.numarical=[];
            x.FittnessValues=[];
            for i=1:length(user.AllPossibleCells(1,:))
                x.numarical(end+1)=rand(1);
                x.cell(:,end+1)=user.AllPossibleCells(:,i);
            end
            x.binary=zeros(1,length(x.numarical));
            [maxval,index]=max(x.numarical);
            x.binary(index)=1;
            x.cell(7,:)=NormalizePopulation1(x.cell(5,:)); %SINR
            x.cell(8,:)=NormalizePopulation1(x.cell(6,:));%POWER
            x.FittnessValues=CalculateFitness(x.cell(7,:),x.cell(8,:),index);
            x = rmfield(x,'numarical');
            NewUsersArray=[NewUsersArray,x];
            OverAllFitness=OverAllFitness+x.FittnessValues;
        end
    end
    
    PopulationArray(1,k).Genes=NewUsersArray;
    PopulationArray(1,k).Cost=OverAllFitness;
    PopulationArray(1,k).Rank = [];
    PopulationArray(1,k).DominationSet = [];
    PopulationArray(1,k).DominatedCount = [];
    PopulationArray(1,k).NormalizedCost = [];
    PopulationArray(1,k).AssociatedRef = [];
    PopulationArray(1,k).DistanceToAssociatedRef = [];
end

end

