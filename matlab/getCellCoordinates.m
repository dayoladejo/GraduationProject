function [X,Y] = getCellCoordinates(AllClusters,Ids)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(AllClusters)
    cluster=AllClusters(i);
    if(cluster.Id==Ids(1))
        if(Ids(3)==-1)
            for k=1:length(cluster.Cells)
                Macrocell=cluster.Cells(k);
                if(Macrocell.Id==Ids(2))
                    X=cluster.xaxis+Macrocell.xaxis;
                    Y=cluster.yaxis+Macrocell.yaxis;
                    return
                end
            end
        else
            for k=1:length(cluster.Cells)
                Macrocell=cluster.Cells(k);
                if(Macrocell.Id==Ids(2))
                    for j=1:length(Macrocell.ArrayOfFemtos)
                        FemtoCell=Macrocell.ArrayOfFemtos(j);
                        if(FemtoCell.Id==Ids(3))
                          X=cluster.xaxis+Macrocell.xaxis+FemtoCell.xaxis;
                          Y=cluster.yaxis+Macrocell.yaxis+FemtoCell.yaxis;
                          return
                        end
                    end
                end
            end
        end
    end
end
end

