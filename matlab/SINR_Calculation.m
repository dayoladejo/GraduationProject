function [Allusers,Temp] = SINR_Calculation(users,AllCellsArray)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for i=1:length(users)
    user=users(i);
    if(~isempty(user.AllPossibleCells))
        for k=1:length(user.AllPossibleCells(1,:))
            [Array,index]=FindCell(AllCellsArray,user.AllPossibleCells(:,k));
            x=Array(4);
            y=Array(5);
            D=sqrt((user.xaxis-x)^2+(user.yaxis-y)^2);
            users(i).AllPossibleCells(4,k)=D;
        end
    end
end
Keys={'NumberOfUsers','UsersIds'};
Values={0,[]};
Temp={};
for i=1:length(AllCellsArray)
    Temp{i}=containers.Map(Keys,Values);
end

for i=1:length(users)
    user=users(i);
    if(isempty(user.AllPossibleCells))
    else
        for k=1:length(user.AllPossibleCells(1,:))
            cellConnecting_to=user.AllPossibleCells(:,k);
            x=FindAllCellsIdsAndDistance_ByResourceBlockId(AllCellsArray,user.ResourceBlock_Ids_AllPossibleCells(k),user);
            SINR=0;
            Pi=0;
            if(x~=0)
                if(cellConnecting_to(3)~=-1)
                    Pr=(Cell.Pt_femto*Cell.Gt_femto*User.Gr*Cell.lamda_femto^2)/((4*pi)^2*cellConnecting_to(4)^Cell.alpha);
                elseif(cellConnecting_to(3)==-1)
                    Pr=(Cell.Pt_macro*Cell.Gt_macro*User.Gr*Cell.lamda_macro^2)/((4*pi)^2*cellConnecting_to(4)^Cell.alpha);
                end
                
                for j=1:length(x(1,:))
                    ReuseCell=x(:,j);
                    if(ReuseCell(3)~=-1)
                        Pi=Pi+(Cell.Pt_femto*Cell.Gt_femto*User.Gr*Cell.lamda_femto^2)/((4*pi)^2*ReuseCell(4)^Cell.alpha);
                    elseif(ReuseCell(3)==-1)
                        Pi=Pi+(Cell.Pt_macro*Cell.Gt_macro*User.Gr*Cell.lamda_macro^2)/((4*pi)^2*ReuseCell(4)^Cell.alpha);
                    end
                end
                SINR=Pr/(Pi+Cell.TherminalNoise);
            else
                if(cellConnecting_to(3)~=-1)
                    Pr=(Cell.Pt_femto*Cell.Gt_femto*User.Gr*Cell.lamda_femto^2)/((4*pi)^2*cellConnecting_to(4)^Cell.alpha);
                elseif(cellConnecting_to(3)==-1)
                    Pr=(Cell.Pt_macro*Cell.Gt_macro*User.Gr*Cell.lamda_macro^2)/((4*pi)^2*cellConnecting_to(4)^Cell.alpha);
                end
                SINR=Pr/(Pi+Cell.TherminalNoise);
            end
            user.AllPossibleCells(5,k)=SINR;
        end
        ComparisonArray=user.AllPossibleCells(5,:);
        for k=1:length(ComparisonArray)
             [CellIds,IndexOfCell]=FindCell(AllCellsArray,user.AllPossibleCells(1:3,k));
             NumOfUsersConnecting=Temp{IndexOfCell}('NumberOfUsers');
             ComparisonArray(k)=ComparisonArray(k)/(NumOfUsersConnecting+1);
        end
        [maxval,index]=max(ComparisonArray);
%         [maxval,index]=max(user.AllPossibleCells(5,:));
        user.CellConnectingTo=user.AllPossibleCells(1:3,index);
        [CellIds,IndexOfCell]=FindCell(AllCellsArray,user.CellConnectingTo);
        Temp{IndexOfCell}('NumberOfUsers')=Temp{IndexOfCell}('NumberOfUsers')+1;
        Temp{IndexOfCell}('UsersIds')=[Temp{IndexOfCell}('UsersIds'),user.Id];
        if(user.CellConnectingTo(3)==-1)
            user.Type=0;
        else
            user.Type=1;
        end
        user.SINR=maxval;
        user.powerRecived=user.AllPossibleCells(4,index);
    end
    users(i)=user;
end
Allusers=users;
end

