function [FirstGenes,SecondGenes] = crossover(FirstGenes,SecondGenes)
Number_Of_genes=numel(FirstGenes);
Number_of_genes_for_crossOver=ceil(Number_Of_genes*rand(1));
CrossOverGenes=randperm(Number_Of_genes,Number_of_genes_for_crossOver);
for k=1:Number_of_genes_for_crossOver
    [FirstGenes(CrossOverGenes(k)), SecondGenes(CrossOverGenes(k))] = deal(SecondGenes(CrossOverGenes(k)),FirstGenes(CrossOverGenes(k)));
end
end


