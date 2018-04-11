classdef Cell
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    %properties(Constant)
    %    MaxRadius=1000;
    % end
    properties (Constant)
            Gt_macro=1;
            Gt_femto=1;
            Center_Freq_macro=6*10^9;
            Center_Freq_femto=30*10^9;
            Pt_macro=1;
            Pt_femto=0.15;
            lamda_macro=(3*10^8)/Cell.Center_Freq_macro;
            lamda_femto=(3*10^8)/Cell.Center_Freq_femto;
            Max_Number_of_FemtoCells=10;
    end
    properties(SetAccess = private)
        Id=0;
        xaxis=0;%cluster 
        yaxis=0;%cluster
        range=0;  % the radius of BS
        Resources_Block=0;
        type=0;%0->macro,1->femto
        ArrayOfFemtos=0;
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


