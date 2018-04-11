function AllCellsIds = GetAllCellsIds_ByResourceBlockId(AllClusters,Id,user)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
AllCellsIds=0;
for i=1:length(AllClusters)
    cluster=AllClusters(i);
    for k=1:length(cluster.Cells)
        MacroCell=cluster.Cells(k);
        if(MacroCell.Resources_Block.Id==Id)
            if(AllCellsIds==0)
                len=1;
            else
                len=length(AllCellsIds(1,:))+1;
            end
            flag=1;
            for n=1:length(user.AllPossibleCells(1,:))
                cellids=user.AllPossibleCells(:,n);
                if(cluster.Id==cellids(1) && MacroCell.Id==cellids(2))
                   flag=0;
                end
            end
            if(flag==1)
            AllCellsIds(1,len)=cluster.Id;
            AllCellsIds(2,len)=MacroCell.Id;
            AllCellsIds(3,len)=-1;
            [x,y]=getCellCoordinates(AllClusters,AllCellsIds(:,len));
            AllCellsIds(4,len)=sqrt((user.xaxis-x)^2+(user.yaxis-y)^2);
            end
        end
        for j=1:length(MacroCell.ArrayOfFemtos)
            FemtoCell=MacroCell.ArrayOfFemtos(j);
            if(FemtoCell.Resources_Block.Id==Id)
                if (AllCellsIds==0)
                    len=1;
                else
                    len=length(AllCellsIds(1,:))+1;
                end
                flag=1;
                for n=1:length(user.AllPossibleCells(1,:))
                    cellids=user.AllPossibleCells(:,n);
                    if(cluster.Id==cellids(1) && MacroCell.Id==cellids(2) &&FemtoCell.Id==cellids(3))
                       flag=0;
                    end
                end
                if(flag==1)
                AllCellsIds(1,len)=cluster.Id;
                AllCellsIds(2,len)=MacroCell.Id;
                AllCellsIds(3,len)=FemtoCell.Id;
                [x,y]=getCellCoordinates(AllClusters,AllCellsIds(:,len));
                AllCellsIds(4,len)=sqrt((user.xaxis-x)^2+(user.yaxis-y)^2);
                end
            end
        end
    end
end

