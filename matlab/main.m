%% input Section
clear all;
%inputs:
NumberOfClusters=1;%max number =61
Frequency_Range=[100000,200000];%[min frequency ,max frequency]
Channel_Bandwidth=10;
Area=100000*100000; %m2
outer_radius_Macro=1000; %m cell outer radius
outer_radius_Femto=100;
X=5000;
Y=5000;
Number_Of_Users=500;
ChannelsID=0;
ColorStep=0.2;
overLap_femto=0.5;
Number_Of_Femtos=30;
inner_radius_empty_ratio=0.2;
%% tipical values (I,J)==>(0,1),(1,0),(1,1),(0,2),(1,2),(2,1),(2,2),(0,3),(3,0),(1,3),(3,1),(2,3),(3,2),(3,3),(3,4),(4,5),(5,4)
I=1;
J=1;
%% pre-calculations
color=[];
for i=1:-ColorStep:0
    for j=1:-ColorStep:0
        for k=1:-ColorStep:0
            color=[color;[i j k]];
        end
    end
end
switch NumberOfClusters
    case num2cell(38:61)
        ClustersLevels=5;
    case num2cell(20:37)
        ClustersLevels=4;
    case num2cell(8:19)
        ClustersLevels=3;
    otherwise
        ClustersLevels=2;
end

%% Evaluation Section
Users=AddAllUsers(Number_Of_Users,X+(ClustersLevels)*outer_radius_Macro,X-(ClustersLevels)*outer_radius_Macro);
[AllClusters,AllMacroCells]=SetUpClusters(outer_radius_Macro,I,J,color,NumberOfClusters,Frequency_Range,Channel_Bandwidth,X,Y,Number_Of_Femtos,outer_radius_Femto,overLap_femto,inner_radius_empty_ratio);
for i=1:Number_Of_Users
    user=Users(i);
    for t=1:length(AllClusters)
        cluster=AllClusters(t);
        for j=1:length(AllMacroCells)
            MacroCell=AllClusters(t).Cells(j);
            in1=InHexagon(cluster.xaxis+MacroCell.xaxis,cluster.yaxis+MacroCell.yaxis,MacroCell,user);
            if(in1==1)
                user.AllPossibleCells(end+1)=MacroCell.Id;
            end
            for k=1:length(MacroCell.ArrayOfFemtos)
                FemtoCell=MacroCell.ArrayOfFemtos(k);
                in=InHexagon(cluster.xaxis+MacroCell.xaxis+FemtoCell.xaxis,cluster.yaxis+MacroCell.yaxis+FemtoCell.yaxis,FemtoCell,user);
                if(in==1)
                    user.AllPossibleCells(end+1)=MacroCell.ArrayOfFemtos(k).Id;
                end
            end
        end
    end
    Users(i)=user;
end
DrawTopology(AllClusters,AllMacroCells,Users);
