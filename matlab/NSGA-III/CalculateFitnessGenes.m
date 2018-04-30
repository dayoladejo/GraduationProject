function array = CalculateFitnessGenes(gene)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
sumArray=[0;0];
for i=1:numel(gene)
    sumArray=sumArray+gene(i).FittnessValues;
end
    array=sumArray;
end

