classdef User
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
     properties (Constant)
            Gr=1;
            MinPower_Recive_dbm=-80;
            MinPower_Recive_Watt=(10^(User.MinPower_Recive_dbm/10))*0.001;
    end
    properties (SetAccess = public)
        Id=0;
        xaxis=0;
        yaxis=0;
        AllPossibleCells=[];
        ResourceBlock_Ids_AllPossibleCells=0;
        OtherCells=0;
        CellConnectingTo=0;
        Type=-1;
        SINR=0;
        powerRecived=0;
    end
    
 methods
   function obj = User(xaxis,yaxis)
                obj.Id = User.counter;       
                if nargin>0
                obj.xaxis=xaxis;                
                obj.yaxis=yaxis;
                end

   end
   
 end
 methods(Static)
    function count = counter
       persistent currentCount;
       if isempty(currentCount)
           currentCount = 1;
       else
           currentCount = currentCount + 1;
       end
           count = currentCount;
    end

 end
end


