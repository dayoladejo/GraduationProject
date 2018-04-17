%% input Section
clear all;
close all;
%inputs:
Alpha=2;
NumberOfClusters=7;%max number =61
Frequency_Range=[1*10^9,100*10^9];%[min frequency ,max frequency]
Channel_Bandwidth=10*10^7;
Area=90*90; %m2
outer_radius_Macro=Calculate_Max_Radius('macro',Alpha); %m cell outer radius
outer_radius_Femto=Calculate_Max_Radius('femto',Alpha);
Area_Of_Macro=3*sqrt(3)*outer_radius_Macro/2;
[I,J]=Determine_I_J(Area,Area_Of_Macro);
X=5000;
Y=5000;
Number_Of_Users=3000;
ChannelsID=0;
ColorStep=0.4;
overLap_femto=0.3;
Number_Of_Femtos=18;
inner_radius_empty_ratio=0.2;
additionPersentageFemto=0.5;
additionPersentageMacro=0.1;

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
%Number_Of_Users,X+outer_radius_Macro,X-outer_radius_Macro
Users=AddAllUsers(Number_Of_Users,-2000,12000);
[AllClusters,AllMacroCells,AllCellsArray]=SetUpClusters(outer_radius_Macro,I,J,color,NumberOfClusters,Frequency_Range,Channel_Bandwidth,X,Y,Number_Of_Femtos,outer_radius_Femto,overLap_femto,inner_radius_empty_ratio);
Users=FindAllPossibleCells_UserCanConnectTo(AllCellsArray,Users,additionPersentageMacro,additionPersentageFemto,outer_radius_Macro,outer_radius_Femto);
[Users,Temp]=SINR_Calculation(Users,AllCellsArray);
MacroBaseStationUsers=0;
FemtoBaseStationUsers=0;
for i=1:length(Temp)
    if(~isempty(Temp{i}('UsersIds')))
        %Temp{i}('UsersIds')
        if(AllCellsArray(3,i)==-1)
        MacroBaseStationUsers=MacroBaseStationUsers+Temp{i}('NumberOfUsers');
        else
        FemtoBaseStationUsers=FemtoBaseStationUsers+Temp{i}('NumberOfUsers');
        end
    end
end

DrawTopology(AllClusters,AllMacroCells,Users,AllCellsArray);
