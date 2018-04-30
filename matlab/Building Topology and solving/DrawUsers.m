function  DrawUsers(Users,AllCellsArray,DrawLines)

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(Users)
    u=Users(i);
    if(~isempty(u.CellConnectingTo))
    Array=FindCell(AllCellsArray,u.CellConnectingTo);
    if(~isempty(Array))
    X=Array(4);
    Y=Array(5);
    end
    end
    if(isempty(u.AllPossibleCells))
    elseif(length(u.AllPossibleCells(1,:))==1)
        plot(u.xaxis,u.yaxis,'+','color','w','Linewidth',1),hold on;
        if(DrawLines)
            plot([u.xaxis X],[u.yaxis Y]);
        end
    elseif(length(u.AllPossibleCells(1,:))==2)
        plot(u.xaxis,u.yaxis,'+','color','b','Linewidth',1),hold on;
        if(DrawLines)
            plot([u.xaxis X],[u.yaxis Y]);
        end
    elseif(length(u.AllPossibleCells(1,:))==3)
        plot(u.xaxis,u.yaxis,'+','color','g','Linewidth',1),hold on;
        if(DrawLines)
            plot([u.xaxis X],[u.yaxis Y]);
        end
    elseif(length(u.AllPossibleCells(1,:))>3)
        plot(u.xaxis,u.yaxis,'+','color','r','Linewidth',1),hold on;
        if(DrawLines)
            plot([u.xaxis X],[u.yaxis Y]);
        end
    end
end

