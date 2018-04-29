function DrawTopology(AllClusters,AllMacroCells,Users,AllCellsArray,background)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%% conatants:
drawLines=1;
LineWidthCells=4;
LineWidthpoints=2;
%% evaluation
for z=1:length(AllClusters)
    for K=1:length(AllMacroCells)
        plot(AllMacroCells(K).xaxis+AllClusters(z).xaxis, AllMacroCells(K).yaxis+AllClusters(z).yaxis, '*', 'MarkerSize', 2, 'LineWidth', LineWidthpoints,'color',AllMacroCells(K).Resources_Block.color), hold on
        DrawHexagon(AllMacroCells(K).xaxis+AllClusters(z).xaxis , AllMacroCells(K).yaxis+AllClusters(z).yaxis , AllMacroCells(K).range,AllMacroCells(K).Resources_Block.color,LineWidthCells);
        for i=1:length(AllMacroCells(K).ArrayOfFemtos)
            plot(AllMacroCells(K).ArrayOfFemtos(i).xaxis+AllClusters(z).xaxis+AllMacroCells(K).xaxis, AllMacroCells(K).ArrayOfFemtos(i).yaxis+AllClusters(z).yaxis+AllMacroCells(K).yaxis, 'o', 'MarkerSize', 2, 'LineWidth', LineWidthpoints,'color',AllMacroCells(K).ArrayOfFemtos(i).Resources_Block.color), hold on
           % DrawHexagon(AllMacroCells(K).ArrayOfFemtos(i).xaxis+AllClusters(z).xaxis+AllMacroCells(K).xaxis , AllMacroCells(K).ArrayOfFemtos(i).yaxis+AllClusters(z).yaxis+AllMacroCells(K).yaxis , AllMacroCells(K).ArrayOfFemtos(i).range,AllMacroCells(K).ArrayOfFemtos(i).Resources_Block.color,LineWidthCells);
        end
    end
%     plot(AllMacroCells(1).xaxis+AllClusters(z).xaxis, AllMacroCells(1).yaxis+AllClusters(z).yaxis, 'go', 'MarkerSize', 2, 'LineWidth', LineWidthpoints,'color',AllMacroCells(1).Resources_Block.color), hold on
%     DrawHexagon(AllMacroCells(1).xaxis+AllClusters(z).xaxis , AllMacroCells(1).yaxis+AllClusters(z).yaxis , AllMacroCells(1).range,AllMacroCells(1).Resources_Block.color,LineWidthCells);
    
end
DrawUsers(Users,AllCellsArray,drawLines);
%grid on, grid minor;
axis([-inf inf -inf inf]);
pbaspect([1 1 1]);
if(background=='w')
    whitebg
    set(gcf,'color','w');
end
end

