function CrossOverArray = crossover(NumberOfPopulation,Number_Of_genes,PopulationArray)
    
    MattingArray1={};
    MattingArray2={};
    for i=1:NumberOfPopulation
        randomNumber=rand(1);
        for k=1:NumberOfPopulation
            if(randomNumber<PopulationArray{4,k})
                temp=k;
                break;
            end
        end
        if(i<=NumberOfPopulation/2)
            MattingArray1(:,i)=PopulationArray(:,temp);
        else
            MattingArray2(:,mod(i,(NumberOfPopulation/2)+1)+1)=PopulationArray(:,temp);
        end
    end
    CrossOverArray={};
    
    for i=1:NumberOfPopulation/2
        Number_of_genes_for_crossOver=ceil(Number_Of_genes*rand(1));
        CrossOverGenes=randperm(Number_Of_genes,Number_of_genes_for_crossOver);
        firstChromosome=MattingArray1{1,i};
        secondChromosome=MattingArray2{1,i};
        for k=1:Number_of_genes_for_crossOver
            [firstChromosome(CrossOverGenes(k)), secondChromosome(CrossOverGenes(k))] = deal(secondChromosome(CrossOverGenes(k)),firstChromosome(CrossOverGenes(k)));
        end
        CrossOverArray{2*i-1}=firstChromosome;
        CrossOverArray{2*i}=secondChromosome;
    end
    
end