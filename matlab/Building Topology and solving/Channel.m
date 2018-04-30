classdef Channel
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
       properties (Constant)
            Channel_Capacity=1;
       end
    properties
        Id=0;
        MinFreq=0;%Hz
        MaxFreq=0;
        Bandwidth=0;%Hz
    end
    
    methods
        function obj = Channel(MinFerq,Bandwidth)
            obj.Id = Channel.counter;
            if nargin>0
                obj.MinFreq=MinFerq;
                obj.Bandwidth=Bandwidth;
                obj.MaxFreq=MinFerq+Bandwidth;
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

