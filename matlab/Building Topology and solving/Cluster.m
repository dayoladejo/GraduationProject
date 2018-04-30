classdef Cluster
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(SetAccess = public)
        Id=0;
        NumberOfCells=0;
        xaxis=0;
        yaxis=0;
        Cells=Cell;
        i=0;
        j=0;
    end
    
    methods
        function obj = Cluster(i,j,xaxis,yaxis,Cells)
            obj.Id = Cluster.counter;
            
            if nargin>0
                obj.i=i;
                obj.j=j;
                obj.NumberOfCells=power(i,2)+power(j,2)+i*j;
                obj.xaxis=xaxis;
                obj.yaxis=yaxis;
                obj.Cells=Cells;
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

