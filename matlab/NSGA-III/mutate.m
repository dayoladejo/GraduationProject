function Genes = mutate(Genes,MutationPercentage)
% %mutation
Number_Of_genes=numel(Genes);
        Number_of_genes_for_Mutation=ceil(Number_Of_genes*rand(1));
        MutationGenes=randperm(Number_Of_genes,ceil(Number_of_genes_for_Mutation*MutationPercentage));
        for kk=1:length(MutationGenes)
            lengthGene=length(Genes(MutationGenes(kk)).binary);
            oneIndex=find(Genes(MutationGenes(kk)).binary,1);
            while(1)
                changedOne=ceil(lengthGene*rand(1));
                if(changedOne~=oneIndex)
                    break;
                end
            end
            Genes(MutationGenes(kk)).binary(oneIndex)=0;
            Genes(MutationGenes(kk)).binary(changedOne)=1;
            Genes(MutationGenes(kk)).FittnessVall=CalculateFitness(Genes(MutationGenes(kk)).cell(7,:),Genes(MutationGenes(kk)).cell(8,:),changedOne);
        end
% %end of mutationend
end

