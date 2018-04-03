classdef Cell
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    %properties(Constant)
    %    MaxRadius=1000;
    % end
    
    properties(SetAccess = private)
        Id=0;
        xaxis=0;%cluster 
        yaxis=0;%cluster
        range=0;  % the radius of BS
        Resources_Block=0;
        type=0;%0->macro,1->femto
        ArrayOfFemtos=0;
        Pt=0;
        Gt=0;
        
    end
    
    methods
        function obj = Cell(xaxis,yaxis,range,Resources_Blocks,type,ArrayOfFemtos)
            obj.Id = Cell.counter;
            if nargin>0
            obj.xaxis=xaxis;
            obj.yaxis=yaxis;
            obj.range=range;
            obj.Resources_Block=Resources_Blocks;
            obj.type=type;
            obj.ArrayOfFemtos=ArrayOfFemtos;
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


