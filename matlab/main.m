%% input Section
clear all;
close all;
%inputs:
Alpha=2;
NumberOfClusters=1;%max number =61
Frequency_Range=[1*10^9,100*10^9];%[min frequency ,max frequency]
Channel_Bandwidth=10*10^7;
Area=90*90; %m2
outer_radius_Macro=Calculate_Max_Radius('macro',Alpha); %m cell outer radius
outer_radius_Femto=Calculate_Max_Radius('femto',Alpha);
Area_Of_Macro=3*sqrt(3)*outer_radius_Macro/2;
[I,J]=Determine_I_J(Area,Area_Of_Macro);
X=5000;
Y=5000;
Number_Of_Users=100;
ChannelsID=0;
ColorStep=0.2;
overLap_femto=0.1;
Number_Of_Femtos=20;
inner_radius_empty_ratio=0.2;

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
Users=AddAllUsers(Number_Of_Users,X+outer_radius_Macro,X-outer_radius_Macro);
[AllClusters,AllMacroCells]=SetUpClusters(outer_radius_Macro,I,J,color,NumberOfClusters,Frequency_Range,Channel_Bandwidth,X,Y,Number_Of_Femtos,outer_radius_Femto,overLap_femto,inner_radius_empty_ratio);
for i=1:Number_Of_Users
    user=Users(i);
    for t=1:length(AllClusters)
        cluster=AllClusters(t);
        for j=1:length(AllMacroCells)
            MacroCell=AllClusters(t).Cells(j);
            in1=InHexagon(cluster.xaxis+MacroCell.xaxis,cluster.yaxis+MacroCell.yaxis,MacroCell,user);
            if(in1==1)
                if isempty(user.AllPossibleCells)
                    len=1;
                else
                    len=length(user.AllPossibleCells(1,:))+1;
                end
                user.AllPossibleCells(1,len)=cluster.Id;
                user.AllPossibleCells(2,len)=MacroCell.Id;
                user.AllPossibleCells(3,len)=-1;
                user.ResourceBlock_Ids_AllPossibleCells(len)=MacroCell.Resources_Block.Id;
            end
            for k=1:length(MacroCell.ArrayOfFemtos)
                FemtoCell=MacroCell.ArrayOfFemtos(k);
                in=InHexagon(cluster.xaxis+MacroCell.xaxis+FemtoCell.xaxis,cluster.yaxis+MacroCell.yaxis+FemtoCell.yaxis,FemtoCell,user);
                if(in==1)
                    if isempty(user.AllPossibleCells)
                        len=1;
                    else
                        len=length(user.AllPossibleCells(1,:))+1;
                    end
                    user.AllPossibleCells(1,len)=cluster.Id;
                    user.AllPossibleCells(2,len)=MacroCell.Id;
                    user.AllPossibleCells(3,len)=FemtoCell.Id;
                    user.ResourceBlock_Ids_AllPossibleCells(len)=FemtoCell.Resources_Block.Id;
                end
            end
        end
    end
    Users(i)=user;
end
[Users,x]=SINR_Calculation(Users,AllClusters);
DrawTopology(AllClusters,AllMacroCells,Users);
