function  DrawUsers(Users)

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(Users)
u=Users(i);
if(length(u.AllPossibleCells)==1)
plot(u.xaxis,u.yaxis,'*','color','w','Linewidth',1),hold on;
elseif(length(u.AllPossibleCells)==2)
plot(u.xaxis,u.yaxis,'*','color','r','Linewidth',1),hold on;
end
end

