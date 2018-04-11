function ResourceBlockId = GetResourceBlockId_ByCellId(AllClusters,CellId)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
ResourceBlockId=0;
for i=1:length(AllClusters)
    cluster=AllClusters(i);
    if(cluster.Id==CellId(1))
        for k=1:length(cluster.Cells)
            MacroCell=cluster.Cells(k);
            if(CellId(3)==-1)
                if(MacroCell.Id==CellId(2))
                    ResourceBlockId=MacroCell.Resources_Block.Id;
                    return;
                end
            else
                for j=1:length(MacroCell.ArrayOfFemtos)
                    FemtoCell=MacroCell.ArrayOfFemtos(j);
                    if(FemtoCell.Id==CellId(3))
                        ResourceBlockId=FemtoCell.Resources_Block.Id;
                        return;
                    end
                end
            end
        end
    end
end
end

