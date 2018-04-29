function PopulationArray = mutaion(Probabilitymutation,MutationPercentage,Number_Of_genes,NumberOfPopulation,PopulationArray)
% %mutation
Probability.mutation=Probabilitymutation;
for cc=1:NumberOfPopulation
    randomNumMutation=rand(1);
    if(randomNumMutation<Probability.mutation)
        Number_of_genes_for_Mutation=ceil(Number_Of_genes*rand(1));
        MutationGenes=randperm(Number_Of_genes,ceil(Number_of_genes_for_Mutation*MutationPercentage));
        for kk=1:length(MutationGenes)
            lengthGene=length(PopulationArray{cc}(1,MutationGenes(kk)).binary);
            oneIndex=find(PopulationArray{cc}(1,MutationGenes(kk)).binary,1);
            while(1)
                changedOne=ceil(lengthGene*rand(1));
                if(changedOne~=oneIndex)
                    break;
                end
            end
            PopulationArray{cc}(1,MutationGenes(kk)).binary(oneIndex)=0;
            PopulationArray{cc}(1,MutationGenes(kk)).binary(changedOne)=1;
            PopulationArray{cc}(1,MutationGenes(kk)).cell(9,changedOne)=PopulationArray{cc}(1,MutationGenes(kk)).cell(7,changedOne)+PopulationArray{cc}(1,MutationGenes(kk)).cell(8,changedOne);
            PopulationArray{cc}(1,MutationGenes(kk)).FittnessVall=PopulationArray{cc}(1,MutationGenes(kk)).cell(9,changedOne);
        end
    end
end
% %end of mutationend
end

