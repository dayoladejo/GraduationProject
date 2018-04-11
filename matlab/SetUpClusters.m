function [AllClusters,AllMacroCells] = SetUpClusters(outer_radius_Macro,I,J,color,NumberOfClusters,Frequency_Range,Channel_Bandwidth,X,Y,NumOfFemtos,outer_radius_Femto,overLap_femto,inner_radius_empty_ratio)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%%pre calculation
%% pre-calculations
switch NumberOfClusters
    case num2cell(38:61)
        ClustersLevels=4;
    case num2cell(20:37)
        ClustersLevels=3;
    case num2cell(8:19)
        ClustersLevels=2;
    otherwise
        ClustersLevels=1;
end

inner_radius_Macro=(outer_radius_Macro/2)*sqrt(3);
inner_radius_Femto=(outer_radius_Femto/2)*sqrt(3);
NumberOfCellsInCluster=I^2+J^2+I*J;
D=sqrt(I^2+J^2+I*J)*2*inner_radius_Macro;

num_Of_available_Channels=(Frequency_Range(2)-Frequency_Range(1))/Channel_Bandwidth;
num_of_Channels_in_Resources_Block=floor(num_Of_available_Channels/(NumberOfCellsInCluster+NumOfFemtos));


XchangesMacroCells=[0,-1.5,-1.5,0,1.5,1.5,0,    0,-1.5,-3,1.5,3,-1.5,0,1.5,3,-3,3,-3,    0,-1.5,-3,-4.5,-4.5,1.5,4.5,-1.5,-3,0,1.5,3,4.5,-4.5,4.5,4.5,3,-4.5   0,-1.5,-3,-4.5,-6,-6,-6,-6,-6,-4.5,-3,-1.5,0,1.5,3,4.5,6,6,6,6,6,4.5,3,1.5]*outer_radius_Macro;%outer_outer_radius
YchangesMacroCells=[0,-1,1,2,1,-1,-2,           4,3,2,3,0,-3,-4,-3,-2,-2,2,0,            6,5,4,3,1,5,-1,-5,-4,-6,-5,-4,-3,-3,1,3,4,-1                          8,7,6,5,4,2,0,-2,-4,-5,-6,-7,-8,-7,-6,-5,-4,-2,0,2,4,5,6,7]*inner_radius_Macro;%inner_outer_radius
switch NumberOfCellsInCluster
    case 9
        XchangesMacroCells([8,19,9,12])=XchangesMacroCells([19,8,12,9]);
        YchangesMacroCells([8,19,9,12])=YchangesMacroCells([19,8,12,9]);
    case 13
        XchangesMacroCells([8,19,10,15])=XchangesMacroCells([19,8,15,10]);
        YchangesMacroCells([8,19,10,15])=YchangesMacroCells([19,8,15,10]);
    case 16
        XchangesMacroCells([14,19,15,18,16,17])=XchangesMacroCells([19,14,18,15,17,16]);
        YchangesMacroCells([14,19,15,18,16,17])=YchangesMacroCells([19,14,18,15,17,16]);
        
end

XchangesCluster=0;
YchangesCluster=0;
XshiftCluster=[I*cos(pi/6)   ,-J*cos(pi/6) ,-I*cos(pi/6)-J*cos(pi/6),-I*cos(pi/6)   ,J*cos(pi/6) ,I*cos(pi/6)+J*cos(pi/6)]      *inner_radius_Macro*2;
YshiftCluster=[I*sin(pi/6)+J ,I+J*sin(pi/6),I*sin(pi/6)-J*sin(pi/6) ,-I*sin(pi/6)-J ,-I+-J*sin(pi/6),-I*sin(pi/6)+J*sin(pi/6)  ]  *inner_radius_Macro*2;
for i=1:ClustersLevels
    XchangesCluster=cat(2,XchangesCluster,i*XshiftCluster);
    YchangesCluster=cat(2,YchangesCluster,i*YshiftCluster);
    if i==2
        XchangesCluster=cat(2,XchangesCluster,(i-1)*circshift(XshiftCluster,1)+(i-1)*XshiftCluster);
        YchangesCluster=cat(2,YchangesCluster,(i-1)*circshift(YshiftCluster,1)+(i-1)*YshiftCluster);
        
    end
    if i==3
        XchangesCluster=cat(2,XchangesCluster,(i-2)*circshift(XshiftCluster,1)+(i-1)*XshiftCluster,(i-1)*circshift(XshiftCluster,1)+(i-2)*XshiftCluster);
        YchangesCluster=cat(2,YchangesCluster,(i-2)*circshift(YshiftCluster,1)+(i-1)*YshiftCluster,(i-1)*circshift(YshiftCluster,1)+(i-2)*YshiftCluster);
        
    end
    if i==4
        XchangesCluster=cat(2,XchangesCluster,(i-3)*circshift(XshiftCluster,1)+(i-1)*XshiftCluster,(i-1)*circshift(XshiftCluster,1)+(i-3)*XshiftCluster,(i-2)*circshift(XshiftCluster,1)+(i-2)*XshiftCluster);
        YchangesCluster=cat(2,YchangesCluster,(i-3)*circshift(YshiftCluster,1)+(i-1)*YshiftCluster,(i-1)*circshift(YshiftCluster,1)+(i-3)*YshiftCluster,(i-2)*circshift(YshiftCluster,1)+(i-2)*YshiftCluster);
    end
end

[XchangesFemtoCells,YchangesFemtoCells]=rand_circ(NumOfFemtos,0,0,inner_radius_Macro,inner_radius_Macro*inner_radius_empty_ratio,outer_radius_Femto,overLap_femto);
NumberOfResourcesBlocks=NumberOfCellsInCluster+min(NumOfFemtos,Cell.Max_Number_of_FemtoCells);
%% evaluation section
for i=1:num_Of_available_Channels
    All_channels(i)=Channel(Frequency_Range(1)+(i-1)*Channel_Bandwidth,Channel_Bandwidth);
end
for i=1:NumberOfResourcesBlocks
    All_Resources_Blocks(i)=Resources_Block(All_channels(((i-1)*num_of_Channels_in_Resources_Block)+1:(i*num_of_Channels_in_Resources_Block)),color(i,:));
end
k=1;
NumberOfReuseFemto=0;
for i=1:NumOfFemtos
    if(k==Cell.Max_Number_of_FemtoCells)
        k=1;
        NumberOfReuseFemto=NumberOfReuseFemto+1;
    end
    AllFemtoCells(i)=Cell(XchangesFemtoCells(i),YchangesFemtoCells(i),outer_radius_Femto,All_Resources_Blocks(k),1,0);
    k=k+1;
end
for k=1:NumberOfCellsInCluster
    AllMacroCells(k)=Cell(XchangesMacroCells(k),YchangesMacroCells(k),outer_radius_Macro,All_Resources_Blocks(k+min(NumOfFemtos,Cell.Max_Number_of_FemtoCells)),0,AllFemtoCells);
end

whitebg([0 0 0]),hold on;
set(gcf,'color','k');
for K=1:NumberOfClusters
    AllClusters(K)=Cluster(I,J,X+XchangesCluster(K),Y+YchangesCluster(K),AllMacroCells);
end
end

