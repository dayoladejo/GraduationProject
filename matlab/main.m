%% input Section
clear all;
%inputs:
NumberOfClusters=1;%max number =61
Frequency_Range=[100000,200000];%[min frequency ,max frequency]
Channel_Bandwidth=10;
Area=100000*100000; %m2
outer_radius_Macro=1000; %m cell outer radius
outer_radius_Femto=100;
X=500;
Y=500;
ChannelsID=0;
ColorStep=0.2;
%% tipical values (I,J)==>(0,1),(1,0),(1,1),(0,2),(1,2),(2,1),(2,2),(0,3),(3,0),(1,3),(3,1),(2,3),(3,2),(3,3),(3,4),(4,5),(5,4)
I=1;
J=0;
%% pre-calculations
color=[];
for i=1:-ColorStep:0
    for j=1:-ColorStep:0
        for k=1:-ColorStep:0
            color=[color;[i j k]];
        end
    end
end

%% Evaluation Section
[AllClusters,AllMacroCells]=SetUpClusters(outer_radius_Macro,I,J,color,NumberOfClusters,Frequency_Range,Channel_Bandwidth,X,Y,4,outer_radius_Femto);
DrawTopology(AllClusters,AllMacroCells);
