%% input Section
clear all;
%inputs:
NumberOfClusters=1;%max number =61
Frequency_Range=[100000,200000];%[min frequency ,max frequency]
Channel_Bandwidth=100;
Area=100*100; %km2
outer_radius=5; %km cell outer radius
LineWidthCells=4;
LineWidthpoints=2;
X=500;
Y=500;
ChannelsID=0;
ColorStep=0.2;
%% tipical values (I,J)==>(0,1),(1,0),(1,1),(0,2),(1,2),(2,1),(2,2),(0,3),(3,0),(1,3),(3,1),(2,3),(3,2),(3,3),(3,4),(4,5),(5,4)
I=2;
J=3;
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

inner_radius=(outer_radius/2)*sqrt(3);

NumberOfCellsInCluster=I^2+J^2+I*J;
D=sqrt(I^2+J^2+I*J)*2*inner_radius;

num_Of_available_Channels=(Frequency_Range(2)-Frequency_Range(1))/Channel_Bandwidth;
num_of_Channels_in_Resources_Block=floor(num_Of_available_Channels/NumberOfCellsInCluster);

color=[];
for i=1:-ColorStep:0
    for j=1:-ColorStep:0
        for k=1:-ColorStep:0
            color=[color;[i j k]];
        end
    end
end
XchangesCells=[0,-1.5,-1.5,0,1.5,1.5,0,    0,-1.5,-3,1.5,3,-1.5,0,1.5,3,-3,3,-3,    0,-1.5,-3,-4.5,-4.5,1.5,4.5,-1.5,-3,0,1.5,3,4.5,-4.5,4.5,4.5,3,-4.5   0,-1.5,-3,-4.5,-6,-6,-6,-6,-6,-4.5,-3,-1.5,0,1.5,3,4.5,6,6,6,6,6,4.5,3,1.5]*outer_radius;%outer_outer_radius
YchangesCells=[0,-1,1,2,1,-1,-2,           4,3,2,3,0,-3,-4,-3,-2,-2,2,0,            6,5,4,3,1,5,-1,-5,-4,-6,-5,-4,-3,-3,1,3,4,-1                          8,7,6,5,4,2,0,-2,-4,-5,-6,-7,-8,-7,-6,-5,-4,-2,0,2,4,5,6,7]*inner_radius;%inner_outer_radius
switch NumberOfCellsInCluster
    case 9
        XchangesCells([8,19,9,12])=XchangesCells([19,8,12,9]);
        YchangesCells([8,19,9,12])=YchangesCells([19,8,12,9]);
    case 13
        XchangesCells([8,19,10,15])=XchangesCells([19,8,15,10]);
        YchangesCells([8,19,10,15])=YchangesCells([19,8,15,10]);
    case 16
        XchangesCells([14,19,15,18,16,17])=XchangesCells([19,14,18,15,17,16]);
        YchangesCells([14,19,15,18,16,17])=YchangesCells([19,14,18,15,17,16]);
     
end

XchangesCluster=0;
YchangesCluster=0;
XshiftCluster=[I*cos(pi/6)   ,-J*cos(pi/6) ,-I*cos(pi/6)-J*cos(pi/6),-I*cos(pi/6)   ,J*cos(pi/6) ,I*cos(pi/6)+J*cos(pi/6)]      *inner_radius*2;
YshiftCluster=[I*sin(pi/6)+J ,I+J*sin(pi/6),I*sin(pi/6)-J*sin(pi/6) ,-I*sin(pi/6)-J ,-I+-J*sin(pi/6),-I*sin(pi/6)+J*sin(pi/6)  ]  *inner_radius*2;
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

%% Evaluation Section
for i=1:num_Of_available_Channels
    All_channels(i)=Channel(Frequency_Range(1)+(i-1)*Channel_Bandwidth,Channel_Bandwidth);
end

for i=1:NumberOfCellsInCluster
    All_Resources_Blocks(i)=Resources_Block(All_channels(((i-1)*num_of_Channels_in_Resources_Block)+1:(i*num_of_Channels_in_Resources_Block)),color(i,:));
end
for k=1:NumberOfCellsInCluster
    AllCells(k)=Cell(XchangesCells(k),YchangesCells(k),outer_radius,All_Resources_Blocks(k));
end

whitebg([0 0 0]),hold on;
set(gcf,'color','k');
for K=1:NumberOfClusters
    AllClusters(K)=Cluster(I,J,X+XchangesCluster(K),Y+YchangesCluster(K),AllCells);
end
for z=1:length(AllClusters)
    for K=2:length(AllCells)
        plot(AllCells(K).xaxis+AllClusters(z).xaxis, AllCells(K).yaxis+AllClusters(z).yaxis, 'go', 'MarkerSize', 2, 'LineWidth', LineWidthpoints,'color',AllCells(K).Resources_Block.color), hold on
        DrawHexagon(AllCells(K).xaxis+AllClusters(z).xaxis , AllCells(K).yaxis+AllClusters(z).yaxis , AllCells(K).range,AllCells(K).Resources_Block.color,LineWidthCells);
    end
    plot(AllCells(1).xaxis+AllClusters(z).xaxis, AllCells(1).yaxis+AllClusters(z).yaxis, 'go', 'MarkerSize', 2, 'LineWidth', LineWidthpoints,'color',AllCells(1).Resources_Block.color), hold on
    DrawHexagon(AllCells(1).xaxis+AllClusters(z).xaxis , AllCells(1).yaxis+AllClusters(z).yaxis , AllCells(1).range,AllCells(1).Resources_Block.color,LineWidthCells);
end

grid on, grid minor;
axis([-inf inf -inf inf]);
pbaspect([1 1 1]);
