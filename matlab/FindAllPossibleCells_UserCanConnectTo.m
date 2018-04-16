function OutUsers = FindAllPossibleCells_UserCanConnectTo(AllCellsArray,InUsers,additionPersentage,outer_radius_Macro,outer_radius_Femto)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(InUsers)
    user=InUsers(i);
    for j=1:length(AllCellsArray)
        cell_index=AllCellsArray(:,j);
        if(cell_index(3)==-1)
            in=InHexagon(cell_index(4),cell_index(5),outer_radius_Macro,user,additionPersentage);
        else
            in=InHexagon(cell_index(4),cell_index(5),outer_radius_Femto,user,additionPersentage);

        end
        if(in)
            user.AllPossibleCells(1:3,end+1)=AllCellsArray(1:3,j);
            user.ResourceBlock_Ids_AllPossibleCells(end+1)=AllCellsArray(6,j);
        end
    end
    OutUsers(i)=user;
end

end

