function [keeperX,keeperY] = rand_circ(N,x,y,r1,r2,r3,overlap)
% Generates N random points in a circle with minimum distance.
% RAND_CIRC(N,x,y,r1) generates N random points in a circle with radius r1 
% and center at (x,y).
NMore=N*1000;
r=r1-r3;
Ns = round(1.28*NMore + 2.5*sqrt(NMore) + 100); % 4/pi = 1.2732
X = rand(Ns,1)*(2*r) - r;
Y = rand(Ns,1)*(2*r) - r;
I = find(sqrt(X.^2 + Y.^2)<=r);
I2= find(sqrt(X.^2 + Y.^2)<=(r2+r3));
I=setdiff(I,I2);
X = X(I(1:length(I))) + x;
Y = Y(I(1:length(I))) + y;

minAllowableDistance = 2*r3-2*r3*overlap;
numberOfPoints = N;
% Initialize first point.
keeperX = X(1);
keeperY = Y(1);
% Try dropping down more points.
counter = 2;
k=2;
while(counter<N+1)
	% Get a trial point.
	thisX = X(k);
	thisY = Y(k);
    k=k+1;
    if k>length(X)
      error('not enough Area');  
    end
	% See how far is is away from existing keeper points.
	distances = sqrt((thisX-keeperX).^2 + (thisY - keeperY).^2);
	minDistance = min(distances);
	if minDistance >= minAllowableDistance
		keeperX(counter) = thisX;
		keeperY(counter) = thisY;
		counter = counter + 1;
	end
end
end