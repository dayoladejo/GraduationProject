function Array = FindCell(AllCellsArray,Ids)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(AllCellsArray(1,:))
    if(isequal(AllCellsArray([1:3],i),Ids))
        Array=AllCellsArray(:,i);
        return
    end
end
end

