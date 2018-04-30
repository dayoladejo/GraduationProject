classdef Resources_Block
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    properties
        Id=0;
        All_channels=0;
        All_channels_IDs=0;
        color=0;
        NumOfChannels=0;
        Block_Capacity=0;
    end
    
    methods
        function obj = Resources_Block(Channels,color)
            obj.Id=Resources_Block.counter;
            if nargin>0
                obj.All_channels=Channels;
                for i=1:length(Channels)
                    obj.All_channels_IDs(i)=Channels(i).Id;
                end
                obj.NumOfChannels=length(Channels);
                obj.Block_Capacity=length(Channels)*Channel.Channel_Capacity;
                obj.color=color;
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

