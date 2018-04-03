 function DrawHexagon(x0,y0,cote,color,L)
   %cote= side size;,(x0,y0) exagon center coordinates;
   if isempty(color)
       color='r';
   end
   x=cote*[-1 -0.5 0.5 1 0.5 -0.5 -1]+x0;
   y=cote*sqrt(3)*[0 -0.5 -0.5 0 0.5 0.5 0]+y0;
   plot(x,y,'color',color,'Linewidth',L);grid;hold on;
   axis([ x0-cote x0+cote y0-cote y0+cote]);
end

