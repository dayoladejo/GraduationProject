classdef User
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    properties (SetAccess = public)
        Id=0;
        xaxis=0;
        yaxis=0;
        AllPossibleCells=[];
        Gr=0;
        
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


