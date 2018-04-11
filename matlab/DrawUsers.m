function  DrawUsers(Users)

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(Users)
    u=Users(i);
    if(isempty(u.AllPossibleCells))
    elseif(length(u.AllPossibleCells(1,:))==1)
        plot(u.xaxis,u.yaxis,'*','color','w','Linewidth',1),hold on;
    elseif(length(u.AllPossibleCells(1,:))==2)
        plot(u.xaxis,u.yaxis,'x','color','b','Linewidth',1),hold on;
    elseif(length(u.AllPossibleCells(1,:))==3)
        plot(u.xaxis,u.yaxis,'^','color','g','Linewidth',1),hold on;
    elseif(length(u.AllPossibleCells(1,:))>3)
        plot(u.xaxis,u.yaxis,'o','color','r','Linewidth',1),hold on;
    end
end

