function [Allusers,x] = SINR_Calculation(users,AllClusters)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

for i=1:length(users)
    user=users(i);
    if(~isempty(user.AllPossibleCells))
        for k=1:length(user.AllPossibleCells(1,:))
            [x,y]=getCellCoordinates(AllClusters,user.AllPossibleCells(:,k));
            D=sqrt((user.xaxis-x)^2+(user.yaxis-y)^2);
            users(i).AllPossibleCells(4,k)=D;
        end
    end
end
for i=1:length(users)
    user=users(i);
    if(isempty(user.AllPossibleCells))
    else
        for k=1:length(user.AllPossibleCells(1,:))
            cellConnecting_to=user.AllPossibleCells(:,k);
            x=GetAllCellsIds_ByResourceBlockId(AllClusters,user.ResourceBlock_Ids_AllPossibleCells(k),user);
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
    end
    users(i)=user;
end
Allusers=users;
end

