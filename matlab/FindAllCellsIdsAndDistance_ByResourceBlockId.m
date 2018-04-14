function Array = FindAllCellsIdsAndDistance_ByResourceBlockId(AllCellsArray,ResourceBlockId,user)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
inArray=[];
for i=1:length(AllCellsArray(1,:))
    if(isequal(AllCellsArray(6,i),ResourceBlockId))
        if(isempty(inArray))
            index=1;
        else
            index=length(inArray(1,:))+1;
        end
        inArray(:,index)=AllCellsArray(:,i);
    end
end
Array=[];
for i=1:length(inArray(1,:))
    
    if(~isempty(user.AllPossibleCells(1,:)))
        for j=1:length(user.AllPossibleCells(1,:))
            if(~isequal(user.AllPossibleCells(1:3,j),inArray(1:3,i)))
                x=inArray(4,i);
                y=inArray(5,i);
                temp=inArray(1:3,i);
                temp(end+1)=sqrt((user.xaxis-x)^2+(user.yaxis-y)^2);
                Array(:,end+1)=temp;
            end
        end
    end    
end
end

